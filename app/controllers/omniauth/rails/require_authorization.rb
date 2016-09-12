# frozen_string_literal: true
module Omniauth
  module Rails
    module RequireAuthorization
      def self.included(klass)
        klass.include Omniauth::Rails::RequireAuthentication
        klass.extend ClassMethods
      end

      module ClassMethods
        private

        def require_authorization(params)
          # TODO: Do not add this before_action in dev_mode
          before_action { |c| c.require_authorization(params) }
        end
      end

      protected

      def require_authorization(params)
        redirect_to_sign_in_url unless authorized?(params)
      end

      private

      def authorized?(params)
        AuthorizationChecker.new(email: authenticated_email, params: params).authorized?
      end
    end
  end
end
