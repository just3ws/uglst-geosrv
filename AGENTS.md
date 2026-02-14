# Repository Guidelines

## Project Structure & Module Organization
This repository is a small Rails API service for IP geolocation.
- `app/controllers/`: request handlers (`geo_controller.rb` is the main endpoint).
- `app/views/geo/location.json.jbuilder`: JSON response shape.
- `config/`: routes, environments, and initializers (`geoip.rb` provides GeoIP client wiring).
- `data/`: GeoIP databases (`GeoIP.dat`, `GeoLiteCity.dat`) used at runtime.
- `spec/`: RSpec suite with request/routing/unit coverage (notably `spec/requests/geo_spec.rb`).
- `lib/`: shared Ruby helpers (for example `lib/metrics_hash.rb`, `lib/geoip_client.rb`).
- `bin/`: local developer workflows (`bin/setup`, `bin/lint`, `bin/ci`).
- `.github/workflows/`: CI and artifact-only CD placeholder workflows.

## Build, Test, and Development Commands
Use Bundler with Ruby `2.7.8` (`.ruby-version`, `.tool-versions`).
- `bundle install`: install gem dependencies.
- `bundle exec rspec`: run the test suite.
- `bundle exec rails server`: run locally for development.
- `bundle exec puma -p 3000`: run with Puma (matches deployment style from `Procfile`).
- `bin/setup`: install dependencies, pin advisory DB, verify local prerequisites.
- `bin/lint`: run RuboCop, Brakeman, and bundler-audit checks.
- `bin/ci`: run tests, lint/security checks, and app boot validation.

## Coding Style & Naming Conventions
- Follow standard Ruby conventions: 2-space indentation, snake_case methods/files, CamelCase classes.
- Keep controllers thin: put reusable logic in `lib/` or service objects when adding complexity.
- Keep JSON response changes explicit in Jbuilder templates, and preserve existing `geoip` envelope keys unless intentionally versioning.
- Prefer small, focused commits over broad refactors in this legacy Rails 5.2 codebase.

## Testing Guidelines
- Framework: `rspec-rails`.
- Put specs under `spec/` mirroring runtime paths.
- Name new specs with `_spec.rb` (for example `spec/requests/geo_spec.rb`).
- When changing geolocation behavior, add specs for both success and fallback paths (invalid or missing IP).
- Run `bundle exec rspec` before opening a PR.
- Keep tests deterministic by stubbing GeoIP lookups in unit/request tests where data drift would create flakes.

## Commit & Pull Request Guidelines
Git history in this repo favors short, imperative commit subjects.
- Keep subject lines concise and action-oriented.
- Group related changes per commit; avoid mixing formatting-only and behavior changes.
- Ensure `bundle exec rspec` is green before every commit.
- PRs should include: purpose, behavior change summary, test evidence (`bundle exec rspec` output), and any config/data impacts.
- Link related issues and include sample JSON responses when API output changes.

## Security & Configuration Notes
- Do not commit secrets; set `SECRET_KEY_BASE` via environment for deployed environments.
- Validate changes to GeoIP data files carefully; they affect production lookup accuracy.
- Keep `vendor/ruby-advisory-db` local-only (`.gitignore`) and use the pinned commit in CI/scripts.
- Run `bin/lint` before opening a PR so security and dependency checks run locally first.
