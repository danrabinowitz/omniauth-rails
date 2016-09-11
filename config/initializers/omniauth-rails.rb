Rails.application.config.middleware.use OmniAuth::Builder do
  config = {
    client_id: 1,
    client_secret: 2,
  }

  provider :google_oauth2, config[:client_id], config[:client_secret],
    {:access_type => 'online', :approval_prompt => 'auto'}
end
