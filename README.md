# Travic CI
[![Build Status](https://travis-ci.org/mykola-kyryk/url_meta_data.svg?branch=master)](https://travis-ci.org/mykola-kyryk/url_meta_data)

# UrlMetaData

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/url_meta_data`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'url_meta_data'
```

And then execute:

    $ bundle

Or install gem directly with:

    $ gem install url_meta_data

## Usage

```Ruby
 result = UrlMetaData::Fetcher.fetch("http://sample.com/page.html") 
 # Result is a hash map with three keys
 # {
 #    title: "Super simple page",
 #    keywords: "page, sample domain, simple test",
 #    description: "This is an example page for testing.",
 # }

```

## Development

Run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mykola-kyryk//url_meta_data. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

