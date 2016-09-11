# frozen_string_literal: true

OmniAuth.config.logger = Rails.logger
# OmniAuth.config.path_prefix = "/auth"
Rails.application.config.middleware.use OmniAuth::Builder do
  config = {
    client_id: ENV["CLIENT_ID"],
    client_secret: ENV["CLIENT_SECRET"],
  }

  provider :google_oauth2, config[:client_id], config[:client_secret],
           access_type: "online", approval_prompt: "auto"
end
