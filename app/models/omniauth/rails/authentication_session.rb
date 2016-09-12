# frozen_string_literal: true
module Omniauth
  module Rails
    class AuthenticationSession
      EMAIL_KEY = "email"
      EXPIRE_AT_KEY = "expire_at"

      def initialize(session)
        @session = session
        reset if expired?
        freeze
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

      def expire_in(duration)
        self.expire_at = (Time.now.to_i + duration)
      end

      def expire_at
        data_store.get(EXPIRE_AT_KEY)
      end

      def expire_at=(expire_at)
        data_store.set(EXPIRE_AT_KEY, expire_at)
      end

      private

      attr_reader :session

      def data_store
        @data_store ||= AuthenticationDataStore.new(session)
      end

      def expired?
        expire_at.present? && expire_at < Time.now.to_i
      end
    end
  end
end
