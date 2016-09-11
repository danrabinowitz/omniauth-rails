# frozen_string_literal: true

config_hash = YAML.load_file(Rails.root.join("config/omniauth_rails.yml"))[Rails.env]

OmniAuth.config.logger = Rails.logger
# OmniAuth.config.path_prefix = "/auth"

Rails.application.config.middleware.use OmniAuth::Builder do
  if config_hash.present?
    raise "You must provide at least one oauth provider" unless config_hash["providers"]
    config_hash["providers"].each do |provider, provider_config|
      case provider
      when "google_oauth2"
        raise "Provider #{provider} requires a client_id" unless provider_config["client_id"]
        raise "Provider #{provider} requires a client_secret" unless provider_config["client_secret"]

        provider(:google_oauth2, provider_config["client_id"], provider_config["client_secret"],
                 access_type: "online", approval_prompt: "auto")

      else
        raise "#{provider} is not currently handled by omniauth_rails."
      end
    end
  end
end
