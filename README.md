# sequel-nonsequential_id
[![Run Status](https://api.shippable.com/projects/5bb3aa2628d5f40700431d28/badge?branch=master)](https://app.shippable.com/github/dashingrocket/sequel-nonsequential_id/dashboard) 
[![Gem Version](https://badge.fury.io/rb/sequel-nonsequential_id.svg)](https://badge.fury.io/rb/sequel-nonsequential_id) 
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/sequel-nonsequential_id?type=total)](https://rubygems.org/gems/sequel-nonsequential_id)

Automatically generate non-sequential (pseudo-random) IDs for Sequel Models

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sequel-nonsequential_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-nonsequential_id

## Usage

```ruby
# Enable nonsequential id for all Models
Sequel::Model.plugin :nonsequential_id

# Enable nonsequential id on a specific model (defaults to the :id field)
class Artist < Sequel::Model
  plugin :nonsequential_id 
end


# Enable nonsequential id on a specific model using a custom id field
class Artist < Sequel::Model
  plugin :nonsequential_id, id_field: :custom_id_field
end
```

## Continuous Integration
Tested in a CI environment against the following Ruby versions:
* ruby-head
* 2.5
* 2.4
* 2.3


## Contributing

1. Fork it ( https://github.com/dashingrocket/sequel-nonsequential_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

