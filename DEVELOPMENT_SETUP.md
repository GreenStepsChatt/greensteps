# Development Setup
Before getting started, you'll need to have Ruby 2.4.1, Rails 5.0.4, and
Postgres 9.6 installed on your machine. If you need help with this, check out
the setup guide from [Go Rails](https://gorails.com/setup). Rather than
following the last set of steps to create a new app, you'll
[fork](https://help.github.com/articles/fork-a-repo/) this repo and then create
a local clone to work with.

You will also need [PhantomJS](http://phantomjs.org/) installed. You can
download it from that webpage, or on a Mac simply run `brew install phantomjs`.

Once you have a copy of this project on your machine, you should run
`bin/setup`. At this point, it's a good idea to

1. run `bin/rspec` to make sure everything was installed properly
2. start the server and explore the app