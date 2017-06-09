# UserTimeZones

UserTimeZones provides an easy way to work with multiple user time zones.



## Requirements

* a user model (`User` by default, but any class name is supported)
* a `current_user` helper


## Installation

To get started, add Authenticate to your `Gemfile` and run `bundle install` to install it:

```ruby
gem 'user_time_zones'
```

Run the install generator:
```sh
rails generate user_time_zones:install
```

Apply the migration the generator created:
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


##### Different user model?

To specify an alternate user model (something other than `User`), use the --model flag. For example, if your user model
is named `Profile`:

```sh
rails generate user_time_zones:install --model Profile
```

## Model attribute and methods

The migration adds a `time_zone` attribute to your user model. This is a string that should contain the name of
a time zone from `ActiveSupport::TimeZone`.

The module `UserTimeZones::User` adds methods  `time_zone_offset=` and `time_zone_offset` methods. 
`time_zone_offset=` receives an offset and sets the `time_zone` attribute based on that offset.

An included validation will confirm that the `time_zone` is known to Rails.


## Usage

`UserTimeZones` has two primary use cases:
* "guess" the user's time zone offset when creating a user account
* apply the user's time zone for the duration of a controller action


### Guess the time zone offset for new users

Include the `UserTimeZones` javascript in your `application.js` and use the form helper `guess_tz_offset_field` to
generate a hidden field, `:time_zone_offset`, that the javascript will set to the user's time zone offset.

A `guess_tz_offset_field_tag` is also included and can be used in place of `guess_tz_offset_field`.

Example form for a new user that includes the `time_zone_offset`:
```erbruby
<%= form_for @user, method: :post do |f| %>
    <%= f.guess_tz_offset_field %>
    <%= f.text_field :first_name %>
    # ...
<% end %>
```
The javascript will calculate the time zone offset, e.g. -9, and set it as a value for the `time_zone_offset` field.
The javascript looks for any element with the attribute `data-behavior="guess-time-zone-offset"`.

Your user controller will need to permit attribute `:time_zone_offset`.

#### Why guess the time zone?

You could ask your new user to pick their time zone from a dropdown during sign-up. That works. But reducing
the complexity of sign-up almost always increases user conversion rate. By determining the user's time zone 
automatically, that's one less thing you have to require from your user.

You can allow the user to edit their time zone later on, either downstream from the sign-up process and in user#edit.


### Applying the user's time zone

`UserTimeZones` will set the time zone to a user's `:time_zone` for the duration of a user's
transaction. This is done in `ApplcationController` with an `around_action` that calls `Time.use_zone`.


### A summary of do’s and don'ts with time zones

Some methods are a lot more time zone friendly than others.
     
     DON’T USE
     * Time.now
     * Date.today
     * Date.today.to_time
     * Time.parse("2015-07-04 17:05:37")
     * Time.strptime(string, "%Y-%m-%dT%H:%M:%S%z")
     
     DO USE
     * Time.current
     * 2.hours.ago
     * Time.zone.today
     * Date.current
     * 1.day.from_now
     * Time.zone.parse("2015-07-04 17:05:37")
     * Time.strptime(string, "%Y-%m-%dT%H:%M:%S%z").in_time_zone

See https://robots.thoughtbot.com/its-about-time-zones for more information.

See Basecamp's [local_time](https://github.com/basecamp/local_time) library for easy, time zone sensitive,
cache friendly client-side local time.


## Contributing

[Bug reports] and [pull requests] are welcome on GitHub at https://github.com/tomichj/user_time_zones. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to 
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

You can contact me directly via twitter at [@JustinTomich](https://twitter.com/justintomich).

[Bug reports]: https://github.com/tomichj/authenticate/issues
[pull requests]: https://github.com/tomichj/user_time_zones/pulls

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

