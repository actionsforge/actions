#!/usr/bin/env python3
"""Append synthetic Pod manifests from workload pod templates for gator test.

Gatekeeper constraints that match kind Pod (e.g. allowPrivilegeEscalation) are not
evaluated against CronJob/Deployment YAML alone. CI and local hooks use this helper.

Covers Deployment, DaemonSet, StatefulSet, Job, and CronJob. DaemonSet and
StatefulSet matter because node-level workloads (CSI drivers, log shippers) are the
ones most likely to need privileged or host access, so omitting them hides exactly
the workloads a pod-security policy is meant to catch.
"""
from __future__ import annotations

import sys
from typing import Any

import yaml


def _namespace_for(
    owner: dict[str, Any],
    template: dict[str, Any],
    default_ns: str,
) -> str:
    """Resolve namespace for a synthetic Pod.

    Kustomize overlays often omit metadata.namespace (Argo sets destination.namespace
    at sync). Falling back to \"default\" false-fails disallow-default-namespace.
    """
    meta = template.get("metadata") or {}
    labels = meta.get("labels") or {}
    owner_labels = (owner.get("metadata") or {}).get("labels") or {}
    return (
        owner.get("metadata", {}).get("namespace")
        or meta.get("namespace")
        or labels.get("name")
        or owner_labels.get("name")
        or labels.get("app.kubernetes.io/part-of")
        or owner_labels.get("app.kubernetes.io/part-of")
        or labels.get("app.kubernetes.io/name")
        or owner_labels.get("app.kubernetes.io/name")
        or default_ns
    )


def _pod_from_template(
    owner: dict[str, Any],
    template: dict[str, Any],
    suffix: str,
    default_ns: str,
) -> dict[str, Any]:
    meta = template.get("metadata") or {}
    labels = meta.get("labels") or {}
    name = owner.get("metadata", {}).get("name", "workload")
    return {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
            "name": f"{name}-{suffix}",
            "namespace": _namespace_for(owner, template, default_ns),
            "labels": labels,
        },
        "spec": template["spec"],
    }


def expand(manifests: str) -> str:
    docs = list(yaml.safe_load_all(manifests))
    ns_names = [
        d["metadata"]["name"]
        for d in docs
        if d and d.get("kind") == "Namespace" and d.get("metadata", {}).get("name")
    ]
    default_ns = ns_names[0] if ns_names else "default"

    out: list[dict[str, Any]] = []
    for doc in docs:
        if not doc:
            continue
        out.append(doc)
        kind = doc.get("kind")
        template = None
        suffix = "pod"
        if kind == "CronJob":
            template = doc["spec"]["jobTemplate"]["spec"]["template"]
            suffix = "job-pod"
        elif kind == "Deployment":
            template = doc["spec"]["template"]
            suffix = "deploy-pod"
        elif kind == "Job":
            template = doc["spec"]["template"]
            suffix = "job-pod"
        elif kind == "DaemonSet":
            template = doc["spec"]["template"]
            suffix = "daemonset-pod"
        elif kind == "StatefulSet":
            template = doc["spec"]["template"]
            suffix = "statefulset-pod"
        if template is not None:
            out.append(_pod_from_template(doc, template, suffix, default_ns))
    # Must emit multi-doc YAML with --- separators. Concatenating dumps without
    # --- collapses into one document (last root keys win), so gator never sees
    # the synthetic Pods and falsely reports PASS.
    chunks: list[str] = []
    for d in out:
        chunks.append("---\n")
        chunks.append(yaml.dump(d, sort_keys=False))
    return "".join(chunks)


def main() -> None:
    print(expand(sys.stdin.read()), end="")


if __name__ == "__main__":
    main()
