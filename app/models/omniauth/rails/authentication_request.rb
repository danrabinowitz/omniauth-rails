# frozen_string_literal: true
module Omniauth
  module Rails
    class AuthenticationRequest
      def initialize(request)
        @request = request
      end

      def persist(authentication_session)
        authentication_session.email = email
      end

      private

      attr_reader :request

      def email
        request.env["omniauth.auth"].info.email
      end
    end
  end
end
