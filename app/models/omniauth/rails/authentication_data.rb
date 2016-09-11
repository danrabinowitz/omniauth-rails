# frozen_string_literal: true
module Omniauth
  module Rails
    class AuthenticationData
      EMAIL_KEY = "email"

      # TODO: Refactor this. Maybe it needs a AuthenticationRequest, AuthenticationSession,
      # and AuthenticationData

      def self.from_request(request)
        new(email: request.env["omniauth.auth"].info.email)
      end

      def self.from_session(session)
        new(email: AuthenticationDataStore.new(session).get(EMAIL_KEY))
      end

      def initialize(email:)
        @email = email
        freeze
      end

      attr_reader :email

      def persist(session)
        AuthenticationDataStore.new(session).set(EMAIL_KEY, email)
      end
    end
  end
end
