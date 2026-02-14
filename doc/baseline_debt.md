# Baseline Debt (Follow-up Issues)

This branch intentionally stabilizes the app on Rails 5.2 / Ruby 2.7 and adds CI/lint/security gates.  
The items below should be tracked as follow-up work.

## 1) Runtime Upgrade Path
- Move from Ruby 2.7.8 to a supported Ruby version.
- Move from Rails 5.2.8.1 to a supported Rails line.

## 2) Security Baseline Cleanup
- Remove Brakeman ignore entries for EOL Ruby/Rails once runtime/framework are upgraded.
- Remove `.bundler-audit.yml` ignore entries by upgrading vulnerable dependencies.

## 3) Dependency Risk Reduction
- Reduce `nokogiri` and Rails component vulnerability exposure by upgrading transitive dependencies.
- Revisit New Relic and other operational gems during framework upgrade.

## 4) CI Strictness
- Keep `bin/ci` as merge gate.
- After runtime/framework upgrades, make security checks fail on all advisories with no baseline exceptions.
