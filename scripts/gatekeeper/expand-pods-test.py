#!/usr/bin/env python3
"""Unit tests for expand-pods.py.

The gatekeeper-validate smoke fixtures cannot catch an expansion regression: a
compliant workload passes whether or not its Pod was synthesized. These tests
assert the Pod actually appears for every supported kind.

Run: python3 scripts/gatekeeper/expand-pods-test.py
"""
from __future__ import annotations

import importlib.util
import pathlib
import unittest

import yaml

_SPEC = importlib.util.spec_from_file_location(
    "expand_pods", pathlib.Path(__file__).with_name("expand-pods.py")
)
expand_pods = importlib.util.module_from_spec(_SPEC)
_SPEC.loader.exec_module(expand_pods)


def pods(manifests: str) -> list[dict]:
    return [
        d
        for d in yaml.safe_load_all(expand_pods.expand(manifests))
        if d and d.get("kind") == "Pod"
    ]


def workload(kind: str, name: str = "wl", namespace: str = "demo") -> str:
    template = {
        "metadata": {"labels": {"app": name}},
        "spec": {"containers": [{"name": "app", "image": "example.com/app:1.0.0"}]},
    }
    spec: dict = {}
    if kind == "CronJob":
        spec = {"schedule": "* * * * *", "jobTemplate": {"spec": {"template": template}}}
    else:
        spec = {"template": template}
    return yaml.dump(
        {
            "apiVersion": "apps/v1",
            "kind": kind,
            "metadata": {"name": name, "namespace": namespace},
            "spec": spec,
        }
    )


class TestExpand(unittest.TestCase):
    def test_every_supported_kind_yields_a_pod(self):
        for kind, suffix in [
            ("Deployment", "deploy-pod"),
            ("DaemonSet", "daemonset-pod"),
            ("StatefulSet", "statefulset-pod"),
            ("Job", "job-pod"),
            ("CronJob", "job-pod"),
        ]:
            with self.subTest(kind=kind):
                got = pods(workload(kind))
                self.assertEqual(len(got), 1, f"{kind} produced no synthetic Pod")
                self.assertEqual(got[0]["metadata"]["name"], f"wl-{suffix}")
                self.assertEqual(got[0]["metadata"]["namespace"], "demo")
                self.assertEqual(
                    got[0]["spec"]["containers"][0]["name"],
                    "app",
                    f"{kind} pod spec not carried over",
                )

    def test_container_security_context_is_preserved(self):
        # The whole point is that pod-security constraints see container fields.
        doc = yaml.safe_load(workload("DaemonSet"))
        doc["spec"]["template"]["spec"]["containers"][0]["securityContext"] = {
            "privileged": True
        }
        got = pods(yaml.dump(doc))
        self.assertTrue(got[0]["spec"]["containers"][0]["securityContext"]["privileged"])

    def test_unsupported_kind_is_passed_through_without_a_pod(self):
        svc = yaml.dump(
            {"apiVersion": "v1", "kind": "Service", "metadata": {"name": "svc"}}
        )
        self.assertEqual(pods(svc), [])

    def test_output_is_multi_doc(self):
        # Missing --- separators collapse everything into one document and gator
        # then never sees the synthetic Pods, reporting a false PASS.
        out = expand_pods.expand(workload("StatefulSet"))
        self.assertGreaterEqual(len([d for d in yaml.safe_load_all(out) if d]), 2)

    def test_namespace_falls_back_to_namespace_manifest(self):
        doc = yaml.safe_load(workload("DaemonSet"))
        del doc["metadata"]["namespace"]
        manifests = (
            yaml.dump(
                {
                    "apiVersion": "v1",
                    "kind": "Namespace",
                    "metadata": {"name": "from-ns-manifest"},
                }
            )
            + "---\n"
            + yaml.dump(doc)
        )
        self.assertEqual(pods(manifests)[0]["metadata"]["namespace"], "from-ns-manifest")


if __name__ == "__main__":
    unittest.main(verbosity=2)
