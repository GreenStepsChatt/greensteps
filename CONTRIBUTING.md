# Contributing

## How to Find Something to Work On
First, checkout the issues that [are labelled as "ready" and listed under the
current milestone (#1)](https://github.com/crawfoal/greensteps/issues?q=is%3Aopen+is%3Aissue+label%3Aready+milestone%3A%22Milestone+%231+%28MVP%29%22).
Pull requests that address these issues will be a top priority. Pull requests
that address issues that are labelled "ready" but aren't in the current
milestone are still appreciated :slightly_smiling_face:.

### Tips for Beginners
- Issues labelled "good first issue" or "first-timers-only" are a good place to
start.
- We are happy to help you through process of submitting your first PR - just
let us know what you need!

### Examples Low Priority Pull Requests
If a pull request isn't aligned with this project's priorities or doesn't follow
established processes, it might be closed with out merging. Here are some
examples:
- **PRs that do not address an existing issue.** If you find a bug or think
a feature should be implemented, we encourage you to submit an issue. After the
issue is opened, we'll discuss the issue's priority and this will help us decide
what milestone it should belong to.
- **PRs that address an issue that is not labelled "ready".** Typically these
issues need other issues to be addressed first.
- **PRs that upgrade gems or the version of Ruby that we're using.** This will
be done once after each milestone, or about once every three months. There are
two exceptions to this rule - (1) when an upgrade is needed in order to
implement or fix something that is already a part of the current milestone and
(2) when an upgrade fixes or is needed in order to address a serious security
vulnerability in this project.

## Pull Request Guidelines
If you haven't already done so, please read our [development
setup](DEVELOPMENT_SETUP.md) instructions.

1. Claim an issue by commenting on it (if one doesn't exist, open one).
2. Fork and clone the repo.
3. Run `bin/setup`.
4. Run the specs and make sure everything passes (see below).
5. Create a branch to work on.
6. Add one or more specs for your changes.
7. Make your changes.
8. Run `bundle exec rake` and make sure your specs pass and that RuboCop doesn't
   report any issues.
9. Push to your fork and submit a pull request. Include a [closing
   keyword](https://help.github.com/articles/closing-issues-using-keywords/) and
   then the issue number in the PR description (e.g. "Resolves #19").

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
