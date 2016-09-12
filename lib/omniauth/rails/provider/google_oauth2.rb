# frozen_string_literal: true
module Omniauth
  module Rails
    module Provider
      class GoogleOauth2
        def initialize(config)
          @config = config
          validate!
        end

        def configure
          # The block passed to OmniAuth::Builder requires that client_id and client_secret be
          # instance variables. So we have these two silly-looking lines.
          client_id = client_id
          client_secret = client_secret
          ::Rails.application.config.middleware.use OmniAuth::Builder do
            provider(:google_oauth2, client_id, client_secret,
                     access_type: "online", approval_prompt: "auto")
          end
        end

        private

        attr_reader :config

        def validate!
          raise "Provider google_oauth2 requires a client_id" unless client_id
          raise "Provider google_oauth2 requires a client_secret" unless client_secret
        end

        def client_id
          config["client_id"]
        end

        def client_secret
          config["client_secret"]
        end
      end
    end
  end
end
