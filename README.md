# Omniauth::Rails

[![Gem Version](https://badge.fury.io/rb/omniauth-rails.svg)](https://badge.fury.io/rb/omniauth-rails)
[![Code Climate](https://codeclimate.com/github/danrabinowitz/omniauth-rails/badges/gpa.svg)](https://codeclimate.com/github/danrabinowitz/omniauth-rails)
[![Build Status](https://travis-ci.org/danrabinowitz/omniauth-rails.svg?branch=master)](https://travis-ci.org/danrabinowitz/omniauth-rails)
[![Test Coverage](https://codeclimate.com/github/danrabinowitz/omniauth-rails/badges/coverage.svg)](https://codeclimate.com/github/danrabinowitz/omniauth-rails/coverage)

A Rails Engine to make it as easy as possible to add oauth authentication to a Rails app.


The canonical use case is this:
You build a simple Rails app for your company. It is for internal use only. Your company uses Google Apps for gmail.

Most existing authentication and authorization systems, like Devise, require a table of Users, and permissions. That requires that users maintain a separate password, and it requires someone to disable an account when an employee leaves.

OmniAuth solves these problems, but can take some effort to configure properly. It is highly flexible and customizable. But adding it can require updates to controllers, the routes file, an initializer. The biggest challenge is that after it authenticates the user, it leaves *persisting* that user's identify as something for the developer to handle.

OmniAuth::Rails makes it as easy as possible to create an admin site. See Usage, below.

Authorization is handled separately.

## Usage

1) Add the gem to your Gemfile
gem 'omniauth-rails'

2) Add a config/omniauth_rails.yml with something like this:
```yml
development:
  providers:
    google_oauth2:
      client_id: <%= ENV["CLIENT_ID"] %>
      client_secret: <%= ENV["CLIENT_SECRET"] %>
  authenticated_root: "/private"
  unauthenticated_root: "/public"
test:
  providers:
    google_oauth2:
      client_id: 1
      client_secret: 2
  authenticated_root: "/private"
  unauthenticated_root: "/public"
production:
  providers:
    google_oauth2:
      client_id: <%= ENV["CLIENT_ID"] %>
      client_secret: <%= ENV["CLIENT_SECRET"] %>
  authenticated_root: "/private"
  unauthenticated_root: "/public"
```
3) In any controllers which you want to protect (such as an admin controller), add this line:
```ruby
require_authorization domains: %w(mydomain.com)
```

That's it. Now anyone trying to hit one of those controllers will only be blocked if they are not authorized.

## Additional configuration

### Automount
By default, Omniauth::Rails sets automount to true. You can override this in the omniauth_rails.yml configuration file.

When automount is true (the default), the engine's routes are mounted in the host application's routes.

When automount is false, you need to add this line to your routes.rb:
```ruby
mount Omniauth::Rails::Engine => OmniAuth.config.path_prefix
```

### path_prefix
The default path_prefix for Omniauth is "/auth". In the unlikely event that this
causes a conflict, it can be changed with the path_prefix configuration parameter.

### autoload_in_application_controller
The default value of autoload_in_application_controller is true.

When it is true, the controller concerns are automatically included in ActionController::Base.

If there is a conflict in having those methods in all controllers, set autoload_in_application_controller to
false and manually add this line to any controllers which require authentication or authorization:
```ruby
include Omniauth::Rails::ControllersConcern
```

## Logging out

In general, there's not much point in "logging out". It wipes the Omniauth::Rails session,
but the browser is still logged in to the provider, which has granted access to the application
(generally) with no expiration. So logging back in requires no credentials.

Bottom line: There's usually no reason to have a logout button when using Omniauth::Rails

## Mutation Testing

Run ```rake mutant```
The output will appear on STDOUT and also in coverage/mutant.out

More info on reading the reports is here: https://github.com/mbj/mutant#reading-reports

## Contributing
PRs are welcome!

### Some things I still want to do

* Add a new AuthorizationType for groups of email addresses
* Run ```rake mutant``` and add all the specs.

## Credit
Thanks to [Paul De Goes](https://github.com/pauldegoes) for the idea for this gem. He
built a similar gem for internal use at LivingSocial.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
