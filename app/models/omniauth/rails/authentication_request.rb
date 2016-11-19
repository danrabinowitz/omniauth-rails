# frozen_string_literal: true
module Omniauth
  module Rails
    class AuthenticationRequest
      def initialize(request)
        @request = request
      end

      def persist(authentication_session)
        authentication_session.email = email
        extra_keys_to_store_in_session.each do |key|
          authentication_session.send("#{key}=", info.send(key.to_sym))
        end
        authentication_session.expire_in(session_duration)
      end

      private

      attr_reader :request

      def email
        info.email
      end

      def info
        request.env["omniauth.auth"].info
      end

      def session_duration
        Configuration.session_duration
      end

      def extra_keys_to_store_in_session
        Configuration.extra_keys_to_store_in_session
      end
    end
  end
end
