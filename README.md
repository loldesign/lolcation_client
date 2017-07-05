# LOLCATION CLIENT
[![Build Status][travis_badge]][travis]
[![RubyGems][gem_version_badge]][ruby_gems]
[![Code Climate][code_climate_badge]][code_climate]
[![Gemnasium][gemnasium_badge]][gemnasium]
[![RubyGems][gem_downloads_badge]][ruby_gems]

A Rails GEM to use Lolcation Service.

## Getting started
You can add it to your Gemfile with:

gem 'lolcation_client'
Then run bundle install

Next, you need to run the generator:

`$ rails generate lolcation_client:install`

and

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

`$ rails generate lolcation_client:migration MODEL`

then run:

`$ rails db:migrate`

DO NOT FORGET TO SET UP YOUR LOLCATION TOKEN AT `config/lolcation.yml`

## Find closest localizations with the method `near_me`
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

![LolDesign](http://novo.loldesign.com.br/wp-content/uploads/2015/12/LolDesign.svg)

This gem was created and is maintained by [LolDesign](https://github.com/loldesign).


[LolDesign]: http://loldesign.com.br
[gem_version_badge]: http://img.shields.io/gem/v/lolcation_client.svg?style=flat
[gem_downloads_badge]: http://img.shields.io/gem/dt/lolcation_client.svg?style=flat
[ruby_gems]: http://rubygems.org/gems/lolcation_client
[code_climate]: https://codeclimate.com/github/loldesign/lolcation_client
[code_climate_badge]: http://img.shields.io/codeclimate/github/loldesign/lolcation_client.svg?style=flat
[gemnasium]: https://gemnasium.com/loldesign/lolcation_client
[gemnasium_badge]: http://img.shields.io/gemnasium/loldesign/lolcation_client.svg?style=flat
[travis]: https://travis-ci.org/loldesign/lolcation_client
[travis_badge]: http://img.shields.io/travis/loldesign/lolcation_client/master.svg?style=flat
