# frozen_string_literal: true
module Omniauth
  module Rails
    module Provider
      # See more info here:
      # https://github.com/zquestz/omniauth-google-oauth2/blob/master/README.md
      class GoogleOauth2
        def initialize(config)
          @config = config
          validate!
        end

        def client_id
          config["client_id"]
        end

        def client_secret
          config["client_secret"]
        end

        def params
          {
            access_type: "online",
            approval_prompt: "auto",
            # prompt: "none", # none, consent, select_account
          }
        end

        def configure
          this_provider = self
          ::Rails.application.config.middleware.use OmniAuth::Builder do
            provider(
              :google_oauth2,
              this_provider.client_id,
              this_provider.client_secret,
              this_provider.params,
            )
          end
        end

        private

        attr_reader :config

        def validate!
          raise "Provider google_oauth2 requires a client_id" unless config["client_id"]
          raise "Provider google_oauth2 requires a client_secret" unless config["client_secret"]
        end
      end
    end
  end
end
