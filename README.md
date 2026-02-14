# uglst-geosrv

[![CI](https://github.com/just3ws/uglst-geosrv/actions/workflows/ci.yml/badge.svg)](https://github.com/just3ws/uglst-geosrv/actions/workflows/ci.yml)

IP geolocation API service backed by MaxMind GeoIP data.

## Quickstart

1. Install dependencies and local tooling:

```bash
bin/setup
```

2. Run tests:

```bash
bundle exec rspec
```

3. Run lint and security checks:

```bash
bin/lint
```

4. Run full local CI parity checks:

```bash
bin/ci
```

5. Start the service:

```bash
bundle exec rails server
```

## Notes

- API root endpoint: `GET /`
- Response envelope: `geoip`
- Development details: `doc/development.md`
