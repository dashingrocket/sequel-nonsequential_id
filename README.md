# sequel-unique_id
[![Run Status](https://api.shippable.com/projects/5bb3aa2628d5f40700431d28/badge?branch=master)]() 
[![Gem Version](https://badge.fury.io/rb/sequel-unique_id.svg)](http://badge.fury.io/rb/sequel-unique_id) 
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/sequel-unique_id?type=total)](https://rubygems.org/gems/sequel-unique_id)

Automatically generate non-sequential (pseudo-random) IDs for Sequel Models

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sequel-unique_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-unique_id

## Usage

```ruby
# Enable unique id for all Models
Sequel::Model.plugin :unique_id

# Enable unique id on a specific model (defaults to the :id field)
class Artist < Sequel::Model
  plugin :unique_id 
end


# Enable unique id on a specific model using a custom id field
class Artist < Sequel::Model
  plugin :unique_id, id_field: :custom_id_field
end
```

## Continuous Integration
Tested in a CI environment against the following Ruby versions:
* ruby-head
* 2.5.1


## Contributing

1. Fork it ( https://github.com/dashingrocket/sequel-unique_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

