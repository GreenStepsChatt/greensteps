# Contributing

## Special Issue Tags
Issues might have one of two special tags:
- **first-timers-only**: for developers who have never submitted a pull request
  to **any** open source project
- **great first issue**: beginner friendly; a typical beginner would go through
quite a few of these before moving to more complex issues

When I'm doing development, I'm always looking for small issues that are easy
for new developers to tackle. Please try to respect these tags - it can be hard
to come up with small, isolated issues like these and we want to make sure they
are going to people of an appropriate skill level.

That said, if these issues have been laying around for an extended period of
time (like 1 month +), or other work is waiting for them to be completed, then
it makes sense for more experienced developers to fix them.

## Take the Following Steps to Open a PR

1. Claim an issue by commenting on it (if one doesn't exist, open one).
2. Fork and clone the repo.
3. Run `bin/setup`.
4. Run the specs and make sure everything passes (see below).
5. Add one or more specs for your changes.
6. Make your changes.
7. Make sure your specs pass and that RuboCop doesn't report any new issues.
8. Push to your fork and submit a pull request. Include the issue number in the PR description (e.g. "Resolves #19").

Once you've submitted a PR, Heroku will create a review app with your code which you can access at https://greensteps-pr-###.herokuapp.com/ (replace ### with your PR number).

## Running Specs

We've set up two main ways to run specs...

### During Development

1. Use `bundle exec guard` to have specs automatically run when changes are saved
2. Use `bin/rspec` followed by command line arguments to run RSpec on demand (you can run it for just specific files or folders, and give it other [command line options](https://relishapp.com/rspec/rspec-core/docs/command-line))

Both of the above commands will run the specs using Spring. This makes it faster to run specs because the Rails environment doesn't have to be loaded each time, but can give an inacurrate test coverage, so that won't be calculated when Spring is running.

### Before Committing, Pushing Changes, Submitting a PR, etc.

`bundle exec rake` will do the following:

1. Run RuboCop with autocorrections turned on
2. Run the full spec suite without Spring and will calculate test coverage
3. Perform a local CodeClimate analysis if you have docker installed and the CodeClimate image downloaded
