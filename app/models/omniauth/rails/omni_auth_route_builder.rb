# frozen_string_literal: true
module Omniauth
  module Rails
    class OmniAuthRouteBuilder
      def initialize
        @provider = "google_oauth2"
      end

      def route
        "/auth/#{provider}"
      end

      private

      attr_reader :provider
    end
  end
end
