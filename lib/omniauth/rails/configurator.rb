# frozen_string_literal: true
module Omniauth
  module Rails
    class Configurator
      REQUIRED_SETTINGS = %i(providers authenticated_root unauthenticated_root).freeze

      def self.default_config_file
        "#{::Rails.root}/config/omniauth_rails.yml"
      end

      def self.from_default_config_file
        ::Rails.logger.info "Omniauth::Rails::Configurator: Loading from " \
                            "default_config_file=#{default_config_file}"
        from_yaml(default_config_file)
      end

      def self.from_yaml(file)
        new(YAML.load(ERB.new(File.read(file)).result)[::Rails.env])
      end

      def initialize(data)
        @data = data
        validate!
      end

      def configure
        OmniAuth.config.logger = ::Rails.logger
        # TODO
        # OmniAuth.config.path_prefix = "/auth"

        configure_providers

        Configuration.authenticated_root = authenticated_root
        Configuration.unauthenticated_root = unauthenticated_root
        Configuration.include_concern_in_application_controller = include_concern_in_application_controller
        Configuration.session_duration = session_duration.seconds if session_duration.present?
      end

      private

      attr_reader :data

      def validate!
        REQUIRED_SETTINGS.each do |setting|
          raise "#{setting} is required" unless send(setting).present?
        end
      end

      def authenticated_root
        data["authenticated_root"]
      end

      def unauthenticated_root
        data["unauthenticated_root"]
      end

      def session_duration
        data["session_duration_in_seconds"]
      end

      def providers
        data["providers"]
      end

      def include_concern_in_application_controller
        data["autoload_in_application_controller"] != false
      end

      def configure_providers
        providers.each do |provider, provider_config|
          Provider.configure(provider, provider_config)
        end
      end
    end
  end
end
