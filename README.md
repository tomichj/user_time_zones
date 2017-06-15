# UserTimeZones

UserTimeZones provides an easy way to work with multiple user time zones.

UserTimeZones is small, simple, and tested. A large percentage of applications will require
support for per-user time zones; this gem can help. The solution is simple, you could implement it 
yourself, but this library will let you implement the solution the same way, every time, without having 
to expend much effort.

[![Gem Version](https://badge.fury.io/rb/user_time_zones.svg)](https://badge.fury.io/rb/user_time_zones) ![Build status](https://travis-ci.org/tomichj/user_time_zones.svg?branch=master) ![Code Climate](https://codeclimate.com/github/tomichj/user_time_zones/badges/gpa.svg)


## Overview

Your `User` model gets a `time_zone` attribute to record the `ActiveSupport::TimeZone` for each user, and
methods to set/get the time zone as an offset (in hours) from `UTC`. Every controller action is executed in 
the context of the user's time zone. And, finally, some javascript will help you initially calculate the 
user's time zone when they sign up.


## Requirements

* Ruby on Rails 5
* a user model (`User` by default, but any class name is supported)
* a `current_user` helper

## Install

To get started, add the gem to your `Gemfile` and run `bundle install` to install it:

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

The install generator will:
* Create a migration that adds a `time_zone` column to your user table.
* Insert `include UserTimeZones::User` into your `User` model.
* Insert `include UserTimeZones::Controller` into your `ApplicationController`.

Include the javascript to calculate a new user's timezone in your `application.js`:
```javascript
//= require user_time_zones
```


##### Different user model?

To specify an alternate user model (something other than `User`), use the --model flag. For example, if your user model
is named `Profile`:

```sh
rails generate user_time_zones:install --model Profile
```


## Use

UserTimeZones has two use cases:
* calculate the user's time zone when creating a user account
* apply the user's time zone for the duration of a controller action

### Calculate the time zone offset for new users

Include the UserTimeZones javascript in your `application.js` and use the form helper `guess_tz_offset_field` to
generate a hidden field, `:time_zone_offset`. The included javascript will set `:time_zone_offset` to the user's 
time zone offset.

A `guess_tz_offset_field_tag` helper is also included.

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


##### Why guess the time zone?

You could ask your new user to pick their time zone from a drop-down during sign-up. That works. But reducing
the complexity of sign-up almost always increases user conversion rate. By determining the user's time zone 
offset and making a guess at their timezone, that's one less thing you have to require from your user at sign up.

You can allow the user to edit their time zone later on, in user#edit or elsewhere.


### Applying the user's time zone

The `UserTimeZones::Controller` module provides an `around_action` that wraps each action a user takes, setting
the time zone to the user's `time_zone` attribute for the duration of the controller action.

`UserTimeZones::Controller` was inserted into your `ApplicationController` by the UserTimeZone's install generator.
 Any controller that needs time zone support should have `include UserTimeZones::Controller`. 


### The User model and time zones

UserTimeZones gives the user a new attribute, `time_zone`, and new methods `time_zone_offset` and `time_zone_offset=`. 
The `time_zone` user attribute is the name of a `ActiveSupport::TimeZone`. The offset methods are the offset of 
that time zone from `UTC`, in hours. Setting the `time_zone_offset` to a new value will change the user's `time_zone`.

Example:
```ruby
>> user.time_zone_offset = -8
=> -8
>> user.time_zone
=> "Pacific Time (US & Canada)"
>> user.time_zone = "Alaska"
=> "Alaska"
>> user.time_zone_offset
=> -9
>> user.time_zone_offset = -7
=> -7
>> user.time_zone
=> "Arizona"
```

Your user model must `include UserTimeZones::User` into your user model. This is done for you by UserTimeZone's
install generator.

### Selecting a time zone

Typically a user is allowed to manually select their time zone in a `user#edit` action. Nothing special here,
just use the Rails form helper time_zone_select. For example:
```erbruby
<%= form_for @user do |f| %>
    <!-- ... -->
    <%= f.label :time_zone, 'Time Zone' %>
    <%= f.time_zone_select :time_zone, ActiveSupport::TimeZone.all %>
    <!-- ... -->
<% end %>
```

You can limit your user to U.S. time zones:
```erbruby
    <%= f.time_zone_select :time_zone, ActiveSupport::TimeZone.us_zones %>
```



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

