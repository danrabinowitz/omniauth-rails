# frozen_string_literal: true
module Omniauth
  module Rails
    class AuthenticationSession
      EMAIL_KEY = "email"

      # TODO: Add a way to store a timestamp of when we logged in, and
      # a way to logout via timeout.

      def initialize(session)
        @session = session
      end

      delegate :reset, to: :data_store

      def authenticated?
        email.present?
      end

      def email
        data_store.get(EMAIL_KEY)
      end

      def email=(email)
        data_store.set(EMAIL_KEY, email)
      end

      private

      attr_reader :session

      def data_store
        @data_store ||= AuthenticationDataStore.new(session)
      end
    end
  end
end
