# An Intro to Autocato for Developers

## Welcome
Hi there! This project is just getting started. Currently, I just have basic user authentication set up (via Devise). I'd love your help with Developing this app! See the [contribution guidelines](CONTRIBUTING.md) for more information. You can check out the production version of this app at https://greensteps.herokuapp.com/.

## Getting Started
Before getting started, you'll need to have Ruby 2.3.1, Rails 5.0.4, and Postgres 9.6 installed on your machine. If you need help with this, check out the setup guide from [Go Rails](https://gorails.com/setup). Rather than following the last set of steps to create a new app, you'll [fork](https://help.github.com/articles/fork-a-repo/) this repo and then create a local clone to work with.

You will also need [PhantomJS](http://phantomjs.org/) installed. You can download it from that webpage, or on a Mac simply run `brew install phantomjs`.

Once you have a copy of this project on your machine, you should run `bin/setup`. At this point, it's a good idea to

1) run `bin/rspec` to make sure everything was installed properly
2) start the server and explore the app

## Where the Project is Headed
Once I have things set up with Heroku, Semaphore, and Code Climate, we'll start with the following:
- [ ] Users can log a trash bag
- [ ] Users can log miles (per hike/walk)
- [ ] Admins can log in to an admin interface
- [ ] Admins can define categories
  - [ ] 10 points = category 1, 20 points = category 2, ...
  - [ ] each category has an associated prize (or prize pool)
- [ ] Trash bags are worth 3 points
- [ ] One mile is worth 1 point
- [ ] Each user's point total is updated when they log trash bags or miles
- [ ] When a user's point total equals or surpasses a category level, they and an admin are notified via email
- [ ] Customize the site's style
