---
title: "octodns-sync"
date: 2026-05-21T10:45:00-04:00
summary: "GitHub Action that runs octodns-sync to test and deploy DNS config from a repo. Manage your zones as code, ship them on push."
tags: ["github-actions", "dns", "octodns", "infrastructure"]
weight: 10
---

[octodns-sync](https://github.com/solvaholic/octodns-sync) is a GitHub
Action that runs [`octodns-sync`](https://github.com/octodns/octodns) to
deploy DNS config from your repository to whichever provider
octodns supports (Route53, Cloudflare, Google Cloud DNS, and more).

Keep your zones as YAML in Git. Open a pull request, see the plan as a
comment, merge to deploy. DNS-as-code with the review workflow you
already use for everything else.

## What it does

- **Plan on pull request**: posts the proposed changes as a PR comment
  so reviewers can see exactly which records will be added, changed, or
  removed.
- **Apply on merge**: runs `octodns-sync --doit` from your default
  branch to push the changes upstream.
- **Multi-provider**: anything `octodns` supports. Credentials come
  from repository secrets you wire into the workflow.
- **Scoped runs**: sync all zones or a named subset.

## Example workflow

```yaml
name: octodns-sync
on:
  push:
    branches: [main]
    paths: ['*.yaml']
jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.10'
      - run: pip install -r requirements.txt
      - uses: solvaholic/octodns-sync@main
        with:
          config_path: public.yaml
          doit: '--doit'
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.route53_aws_key_id }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.route53_aws_secret_access_key }}
```

The full input/output reference and the PR-comment setup are in the
repo README.

## Why

Manual DNS changes are easy to get wrong and hard to audit. Putting
zones in a Git repo gives you diff, review, history, and rollback for
free; `octodns` gives you a portable format across providers; this
action ties them together so a merge is the deploy.

## Links

- **Source**: [solvaholic/octodns-sync](https://github.com/solvaholic/octodns-sync)
- **Underlying tool**: [octodns/octodns](https://github.com/octodns/octodns)
