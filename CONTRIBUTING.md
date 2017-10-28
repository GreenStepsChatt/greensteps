# Contributing

## Special Issue Tags
Issues might have one of three special tags:
- **first-timers-only**: for developers who have never submitted a pull request
  to an open source project
- **beginner-friendly**: like it sounds; a typical beginner would go through
quite a few of these before moving to more complex issues
- **ready**: it is ready for someone to start working on making the changes

## Take the Following Steps to Open a PR

1. Claim an issue by commenting on it (if one doesn't exist, open one).
2. Fork and clone the repo.
3. Run `bin/setup`.
4. Run the specs and make sure everything passes (see below).
5. Add one or more specs for your changes.
6. Make your changes.
7. Make sure your specs pass and that RuboCop doesn't report any new issues.
8. Push to your fork and submit a pull request. Include the issue number in the
   PR description (e.g. "Resolves #19").\*

Once you've submitted a PR, Heroku will create a review app with your code which
you can access at https://greensteps-pr-###.herokuapp.com/ (replace ### with
your PR number).

\*NOTE: In order for Heroku to update your PR app as you add commits, you need
to open a pull request from a feature branch in your fork against the master
branch in the this repo.

## Running Specs

We've set up two main ways to run specs...

### During Development

1. Use `bundle exec guard` to have specs automatically run when changes are
   saved
2. Use `bin/rspec` followed by command line arguments to run RSpec on demand
   (you can run it for just specific files or folders, and give it other
   [command line options](https://relishapp.com/rspec/rspec-core/docs/command-line))

Both of the above commands will run the specs using Spring. This makes it faster
to run specs because the Rails environment doesn't have to be loaded each time,
but can give an inacurrate test coverage, so that won't be calculated when
Spring is running.

### Before Committing, Pushing Changes, Submitting a PR, etc.

`bundle exec rake` will do the following:

1. Run RuboCop with autocorrections turned on
2. Run the full spec suite without Spring and will calculate test coverage
3. Perform a local CodeClimate analysis if you have docker installed and the
   CodeClimate image downloaded
