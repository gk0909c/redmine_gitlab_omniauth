# redmine_gitlab_omniauth
request omniauth from redmine to gitlab as provider

## testing
### unit and functions
```bash
bundle exec rake redmine:plugins:test:units
bundle exec rake redmine:plugins:test:functionals
```

### intagration
integration test using rack middleware fail when rake task, so excute with ruby command.
```bash
bundle exec ruby plugins/redmine_gitlab_omniauth/test/integration/integration_test.rb
```
