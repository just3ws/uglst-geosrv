# Development Guide

## Prerequisites
- Ruby `2.7.8` (see `.ruby-version` and `.tool-versions`)
- Bundler

## Setup
Run:

```bash
bin/setup
```

This installs gems, pins the Ruby advisory database used by `bundle-audit`, and verifies GeoIP data is present.

## Daily Workflow
- Run tests:

```bash
bundle exec rspec
```

- Run static analysis and security checks:

```bash
bin/lint
```

- Run full local CI parity checks:

```bash
bin/ci
```

- Start the API locally:

```bash
bundle exec rails server
```

## Behavioral Notes
- `GET /` returns a JSON payload under `geoip`.
- Query `ip` takes precedence over `request.ip`.
- Blank `ip` (`?ip=`) is treated as missing and falls back to `request.ip`.
- Invalid/malformed IP inputs return `200` with fallback `geoip.ip` rather than raising.
- GeoIP initialization/lookup failures are logged and gracefully fall back to minimal response data.
