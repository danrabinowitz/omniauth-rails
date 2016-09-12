# Omniauth::Rails
A Rails Engine to make it as easy as possible to add oauth authentication to a Rails app.

The canonical use case is this:
You build a simple Rails app for your company. It is for internal use only. Your company uses Google Apps for gmail.

Most existing authentication and authorization systems, like Devise, require a table of Users, and permissions. That requires that users maintain a separate password, and it requires someone to disable an account when an employee leaves.

OmniAuth solves these problems, but can take some effort to configure properly. It is highly flexible and customizable. But adding it can require updates to controllers, the routes file, an initializer. The biggest challenge is that after it authenticates the user, it leaves *persisting* that user's identify as something for the developer to handle.

OmniAuth::Rails makes it as easy as possible to create an admin site. See Usage, below.

Authorization is handled separately.

## TODO

* Add basic Authorization. And maybe a "dev mode" override which simply skips all authentication.

* Search for "TODO" in the code.

## Usage

1. Add the gem to your Gemfile
gem 'omniauth-rails'

2. Add a config/omniauth_rails.yml with something like this:
```yml
development:
  providers:
    google_oauth2:
      client_id: <%= ENV["CLIENT_ID"] %>
      client_secret: <%= ENV["CLIENT_SECRET"] %>
  authenticated_root: "/private"
  unauthenticated_root: "/public"
  session_duration_in_seconds: 5 # The default is 3600 (which is 1 hour)
test:
  providers:
    google_oauth2:
      client_id: 1
      client_secret: 2
  authenticated_root: "/private"
  unauthenticated_root: "/public"
  session_duration_in_seconds: 5 # The default is 3600 (which is 1 hour)
production:
  providers:
    google_oauth2:
      client_id: <%= ENV["CLIENT_ID"] %>
      client_secret: <%= ENV["CLIENT_SECRET"] %>
  authenticated_root: "/private"
  unauthenticated_root: "/public"
  session_duration_in_seconds: 3600 # The default is 3600 (which is 1 hour)
```

3. In any controllers which require authentication, add this line:
```ruby
include Omniauth::Rails::RequireAuthentication
```

## Logging out

In general, there's not much point in "logging out". It wipes the Omniauth::Rails session,
but the browser is still logged in to the provider, which has granted access to the application
(generally) with no expiration. So logging back in requires no credentials.

Bottom line: There's usually no reason to have a logout button when using Omniauth::Rails

## Contributing
PRs are welcome!

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
