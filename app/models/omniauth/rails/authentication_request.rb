# frozen_string_literal: true
module Omniauth
  module Rails
    class AuthenticationRequest
      def initialize(request)
        @request = request
      end

      def persist(authentication_session)
        authentication_session.email = email
        authentication_session.expire_in(session_duration)
      end

      private

      attr_reader :request

      def email
        request.env["omniauth.auth"].info.email
      end

      def session_duration
        # TODO: Make this configurable
        5.seconds
      end
    end
  end
end
