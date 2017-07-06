# LOLCATION CLIENT
[![Build Status][travis_badge]][travis]
[![RubyGems][gem_version_badge]][ruby_gems]
[![Code Climate][code_climate_badge]][code_climate]
[![RubyGems][gem_downloads_badge]][ruby_gems]

A Rails GEM to use Lolcation Service.

## Getting started
Add to your `Gemfile`:

```
gem 'lolcation_client'
```

Then run bundle install

Run the generator:

```
rails generate lolcation_client:install`
```

In your model add follow code:


```ruby
  class LolcalizationModel < ApplicationRecord
    extend LolcationClient
  end
```
You can also define lolcation_fields and lolcation_custom_fields, so you can filter later when you need

```ruby
class LolcalizationModel < ApplicationRecord
  extend LolcationClient

  lolcation_fields latitude: :my_latitude_attr, address_street: :my_street_attr
  lolcation_custom_fields :foo, :bar, :baz
end
```

Run the generator to create location fields:

```
rails generate lolcation_client:migration MODEL
```

Run your migrate:

```
rails db:migrate
```

You must set your __token at :__ `config/lolcation.yml`

```
development:
  token: 'TOKEN'
  sandbox: true
staging:
  token: 'TOKEN'
  sandbox: true
production:
  token: 'TOKEN'

```

## Finding closest localizations with the method `near_me` method

```ruby
LocalizationModel.near_in(latitude: lat, longitude: lgt, distance: 10.0, filter: {foo: 'bar'})
```

* Note that filter will look up for custom_fields!

## Versioning

LOLCATION CLIENT follows the [Semantic Versioning](http://semver.org/) standard.

## Issues

If you have problems, please create a [Github Issue](https://github.com/loldesign/lolcation_client/issues).

## Contributing

Please see [CONTRIBUTING.md](https://github.com/loldesign/lolcation_client/blob/master/CONTRIBUTING.md) for details.

## Maintainers

- [Eduardo Zaghi](https://github.com/eduzera)
- [Marcelo Barreto](https://github.com/marcelobarreto)
- [Paulo Henrique Sacramento](https://github.com/henriquesacramento)

## Release

Follow this steps to release a new version of the gem.

1. Test if everything is running ok;
2. Change version of the gem on `VERSION` constant;
3. Add the release date on the `CHANGELOG`;
4. Do a commit "Bump version x.x.x", follow the semantic version;
5. Run `$ rake release`, this will send the gem to the rubygems;
6. Check if the gem is on the rubygems and the tags are correct on the github;

## Made with love by LolDesign

<img src="http://novo.loldesign.com.br/wp-content/uploads/2015/12/LolDesign.svg" width="150">

This gem was created and is maintained by [LolDesign](https://github.com/loldesign).


[LolDesign]: http://loldesign.com.br
[gem_version_badge]: http://img.shields.io/gem/v/lolcation_client.svg?style=flat
[gem_downloads_badge]: http://img.shields.io/gem/dt/lolcation_client.svg?style=flat
[ruby_gems]: http://rubygems.org/gems/lolcation_client
[code_climate]: https://codeclimate.com/github/loldesign/lolcation_client
[code_climate_badge]: http://img.shields.io/codeclimate/github/loldesign/lolcation_client.svg?style=flat
[travis]: https://travis-ci.org/loldesign/lolcation_client
[travis_badge]: http://img.shields.io/travis/loldesign/lolcation_client/master.svg?style=flat
