# frozen_string_literal: true
module Omniauth
  module Rails
    module Provider
      PROVIDERS = %w(google_oauth2).freeze

      PROVIDERS.each do |provider|
        require "omniauth/rails/provider/#{provider}"
      end

      module_function

      def configure(provider, config)
        raise "Invalid provider" unless PROVIDERS.include?(provider)
        klass = "Omniauth::Rails::Provider::#{provider.camelize}".constantize
        klass.new(config).configure
      end
    end
  end
end
