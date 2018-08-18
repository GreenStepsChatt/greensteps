# Contributing

## How to Find Something to Work On
First, checkout the issues that [are labelled as "ready" and listed under the
current milestone (#2)](https://github.com/crawfoal/greensteps/milestone/2).
Pull requests that address these issues will be a top priority. Pull requests
that address issues that are labelled "ready" and "help wanted" but aren't in 
the current milestone are still appreciated :slightly_smiling_face:. Other 
pull requests, including those that update gems or the Ruby version 
unnecessarily, will be a lower priority and might even be closed without 
merging. That said, we'd love to hear your suggestions on how to make the app 
better, so please don't hesitate to open an issue if you think of something!

From time to time we also have [abandonded PRs](https://github.com/crawfoal/greensteps/pulls?q=is%3Aopen+is%3Apr+label%3Aabandoned) that need to be finished - if there are
any PRs in that list we'd love your help there too!

### Tips for Beginners
- Issues labelled "good first issue" or "first-timers-only" are a good place to
start.
- We are happy to help you through process of submitting your first PR - just
let us know what you need!

## Pull Request Guidelines
If you haven't already done so, please read our [development setup](
DEVELOPMENT_SETUP.md) instructions.

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

Two options:
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
