# frozen_string_literal: true
module Omniauth
  module Rails
    class AuthorizationChecker
      AUTHORIZATION_TYPES = {
        domains: AuthorizationTypes::Domains,
        emails: AuthorizationTypes::Emails,
        regex: AuthorizationTypes::Regex,
      }.freeze

      def initialize(email:, params:)
        @email = email
        @params = params
      end

      def authorized?
        params.map do |key, value|
          raise "Invalid key for authorization constraint" unless AUTHORIZATION_TYPES.key?(key)
          AUTHORIZATION_TYPES[key].new(email: email, value: value).authorized?
        end.all?
      end

      private

      attr_reader :email, :params
    end
  end
end
