# Contributing

We love pull requests. Here's a quick guide:

1. Fork the repo.

1. Create your feature branch (`git checkout -b my-new-feature`)

1. Run the tests. We only take pull requests with passing tests, and it's great
to know that you have a clean slate: `bundle && rake`

1. Add a test for your change. Only refactoring and documentation changes
require no new tests. If you are adding functionality or fixing a bug, we need
a test!

1. Make the test pass.

1. Update [CHANGELOG.md](https://github.com/loldesign/lolcation_client/blob/master/CHANGELOG.md) with a brief description of your changes under the `unreleased` heading.

1. Commit your changes (`git commit -am 'Added some feature'`)

1. Push to the branch (`git push origin my-new-feature`)

1. Create new Pull Request

At this point you're waiting on us. We like to at least give you feedback, if not just
accept it, within a few days, depending on our internal priorities.

Some things that will increase the chance that your pull request is accepted is to follow the practices described on [Ruby style guide](https://github.com/bbatsov/ruby-style-guide), [Rails style guide](https://github.com/bbatsov/rails-style-guide) and [Better Specs](http://betterspecs.org/).

## General rules

- Version upgrade of gems should be done only via PR (without opening an issue before)
- Features should be discussed on issues before opening a PR. If passed 15 days without interaction on the issue(a comment, a pull request) the issue will be closed.
- Every PR of new features/gems should come with the specs/feature of the change

## Removing gems

Pah is an opinionated Rails template. All gems are our recommendations to recurring problems based on our experience. For example, when writing tests that need to access network we recommend using VCR and WebMock.
If you want to make a PR to add/remove gem X, please follow the steps below:

1. Make a PR to our blog and explain the gem's pros and cons, how to use, the tricks etc.
1. Make a PR to remove gem X
