# UserTimeZones

UserTimeZones provides an easy way for each user of your application to have a time zone.


## Requirements

* a user model (typically `User`, but any class name is supported)
* a `current_user` helper


## Installation

To get started, add Authenticate to your `Gemfile` and run `bundle install` to install it:


```ruby
gem 'user_time_zones'
```

Then run the install generator:

```sh
rails generate user_time_zones:install
```

Then apply the migration the generator created:

```sh
rails db:migrate
```

The install generator does the following:
 
* Create a migration, adding a `time_zone` column to your user.
* Insert `include UserTimeZones::User` into your `User` model.
* Insert `include UserTimeZones::Controller` into your `ApplicationController`.

You may optionally include the javascript to guess a new user's timezone in your `application.js`:
```javascript
//= require user_time_zones
```


## Usage

To set a new user's time zone initially, include



## Contributing

[Bug reports] and [pull requests] are welcome on GitHub at https://github.com/tomichj/user_time_zones. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to 
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

You can contact me directly via twitter at [@JustinTomich](https://twitter.com/justintomich).

[Bug reports]: https://github.com/tomichj/authenticate/issues
[pull requests]: https://github.com/tomichj/user_time_zones/pulls

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

