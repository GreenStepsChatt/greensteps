# Contributing

Here are some steps to open a pull request:

1. Claim an issue by commenting on it (if one doesn't exist, open one).
2. Fork and clone the repo.
3. Run `bin/setup`.
4. Run the specs and make sure everything passes.
   - `bin/rspec` will use spring
   - `bundle exec rake spec` won't use spring and will report test coverage
   - `bundle exec guard` will watch for file modifications and run corresponding specs
5. Add one or more specs for your changes.
6. Make your changes.
7. Make sure your specs pass and that RuboCop doesn't report any new issues.
8. Push to your fork and submit a pull request. Include the issue number in the PR description (e.g. "Resolves #19").

Once you've submitted a PR, Heroku will create a review app with your code which you can access at https://greensteps-pr-###.herokuapp.com/ (replace ### with your PR number).
