# frozen_string_literal: true
module Omniauth
  module Rails
    class AuthenticationDataStore
      SCOPE = "OmniauthRailsAuthData"

      def initialize(session)
        @session = session
        freeze
      end

      def get(key)
        return nil if session[SCOPE].nil?
        session[SCOPE][key]
      end

      def set(key, value)
        session[SCOPE] ||= {}
        session[SCOPE][key] = value
      end

      private

      attr_reader :session
    end
  end
end
