# frozen_string_literal: true
module Omniauth
  module Rails
    class AuthenticationRequest
      def initialize(request)
        @request = request
      end

      def persist(authentication_session)
        # TODO: Store the provider in the session
        authentication_session.email = email
        authentication_session.expire_in(session_duration)
        puts "session_duration:     ---> #{session_duration}"
      end

      private

      attr_reader :request

      def email
        request.env["omniauth.auth"].info.email
      end

      def session_duration
        Configuration.session_duration
      end
    end
  end
end
