# frozen_string_literal: true
module Omniauth
  module Rails
    module AuthorizationConcern
      def self.included(klass)
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
        require_authentication # Require authentication before authorization.
        return if performed?
        render_403_forbidden unless authorized?(params)
      end

      private

      def authorized?(params)
        AuthorizationChecker.new(email: authenticated_email, params: params).authorized?
      end

      def render_403_forbidden
        render "omniauth/rails/forbidden", status: :forbidden, layout: false
      end
    end
  end
end
