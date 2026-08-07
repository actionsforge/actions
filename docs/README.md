# Reusable workflows

Call from any repository:

```yaml
jobs:
  example:
    uses: actionsforge/actions/.github/workflows/<name>.yml@main
    with:
      # inputs
    secrets:
      # pass explicitly across organizations
```

Use `@main` for shared hygiene, or pin to a commit SHA when you need a fixed revision.

Each workflow page lists **inputs**, **secrets**, **outputs**, and a minimal example.

Workflows whose filenames start with `_` are internal callers for this repo and are not documented here.

## Hygiene

| Workflow | Summary |
| --- | --- |
| [`markdown-lint`](./workflows/markdown-lint.md) | Lint Markdown with markdownlint-cli |
| [`commitmsg-conform`](./workflows/commitmsg-conform.md) | Enforce conventional commit messages (skips Dependabot) |
| [`yaml-lint`](./workflows/yaml-lint.md) | Lint YAML with yamllint |
| [`validate-devschema`](./workflows/validate-devschema.md) | Validate JSON (e.g. devcontainer) against a schema |

## Kubernetes / policy

| Workflow | Summary |
| --- | --- |
| [`gatekeeper-validate`](./workflows/gatekeeper-validate.md) | `gator test` app overlays against a Gatekeeper policy Git tree |
| [`kustomize-build`](./workflows/kustomize-build.md) | Build every discovered Kustomize root and report all failures |

## CI / language

| Workflow | Summary |
| --- | --- |
| [`node-ci-workflow`](./workflows/node-ci-workflow.md) | Install, test, and optionally build/audit a Node project |
| [`python-lint-test`](./workflows/python-lint-test.md) | Install, lint, and test a Python project |
| [`python-image-validate`](./workflows/python-image-validate.md) | Python lint/test plus Docker image validate |
| [`go-mod-tidy-build`](./workflows/go-mod-tidy-build.md) | go mod tidy check and build |
| [`go-binary-release`](./workflows/go-binary-release.md) | Cross-compile Go binaries and attach to a GitHub Release |

## Docker

| Workflow | Summary |
| --- | --- |
| [`docker-image-validate`](./workflows/docker-image-validate.md) | Build a Docker image and optionally scan with Trivy |
| [`docker-image-publish`](./workflows/docker-image-publish.md) | Build/push to GHCR or ECR (optional Trivy) |
| [`docker-image-release`](./workflows/docker-image-release.md) | Build/push GHCR tags and optionally create a GitHub Release |

## Terraform

| Workflow | Summary |
| --- | --- |
| [`terraform-lint-validate`](./workflows/terraform-lint-validate.md) | terraform fmt/validate (and related checks) |
| [`terraform-docs`](./workflows/terraform-docs.md) | Render terraform-docs into README and push on PRs |
| [`terraform-tag`](./workflows/terraform-tag.md) | Create a Terraform module semver tag (and optional release) |
| [`terraform-tag-and-release`](./workflows/terraform-tag-and-release.md) | Thin caller around terraform-tag with release enabled |
| [`terraform-drift`](./workflows/terraform-drift.md) | Scheduled terraform plan; open an issue (and outputs) on drift |

## Helm

| Workflow | Summary |
| --- | --- |
| [`chart-lint-validate`](./workflows/chart-lint-validate.md) | Helm chart-testing lint/install |
| [`chart-releaser`](./workflows/chart-releaser.md) | Package and release Helm charts with chart-releaser |

## Pages / sites

| Workflow | Summary |
| --- | --- |
| [`github-pages-deploy`](./workflows/github-pages-deploy.md) | Upload static files and deploy to GitHub Pages |
| [`astro-pages-deploy`](./workflows/astro-pages-deploy.md) | Build an Astro site and deploy to GitHub Pages |
| [`jekyll-pages-deploy`](./workflows/jekyll-pages-deploy.md) | Build a Jekyll site and deploy to GitHub Pages |

## Node actions

| Workflow | Summary |
| --- | --- |
| [`node-action-tag-and-release`](./workflows/node-action-tag-and-release.md) | Semver tag + release for Node-based GitHub Actions |

## Repo automation

| Workflow | Summary |
| --- | --- |
| [`auto-assign-issue`](./workflows/auto-assign-issue.md) | Auto-assign new issues |
| [`dependabot-auto-merge`](./workflows/dependabot-auto-merge.md) | Enable GitHub auto-merge for Dependabot PRs |
| [`gh-teams-sync`](./workflows/gh-teams-sync.md) | Sync org teams from a YAML file |

## Notify / secrets

| Workflow | Summary |
| --- | --- |
| [`notify-slack`](./workflows/notify-slack.md) | Post a Slack message via webhook (GitHub secret or Bitwarden) |
| [`bitwarden-get-secret`](./workflows/bitwarden-get-secret.md) | Fetch one Bitwarden SM secret into a job output |

