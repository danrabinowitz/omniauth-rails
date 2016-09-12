# frozen_string_literal: true
module Omniauth
  module Rails
    module Test
      module RequestHelpers
        # Another option for mocking this, is to use something like this:
        # before do
        #   Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        # end

        def sign_in(email)
          fake_session = {}
          data_store = Omniauth::Rails::AuthenticationDataStore.new(fake_session)
          data_store.set("email", email)
          allow(AuthenticationDataStore).to receive(:new).and_return(data_store)
        end

        def authenticated?
          get "/private"
          response.status == 200
        end
      end
    end
  end
end
