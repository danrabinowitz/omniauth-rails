# TODO: Move this into the spec/ directory. It is not part of the Rails engine.
require 'dotenv'
Dotenv.load

Rails.application.config.middleware.use OmniAuth::Builder do
  config = {
    client_id: ENV["CLIENT_ID"],
    client_secret: ENV["CLIENT_SECRET"],
  }

  provider :google_oauth2, config[:client_id], config[:client_secret],
    {:access_type => 'online', :approval_prompt => 'auto'}
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.test_mode = true
