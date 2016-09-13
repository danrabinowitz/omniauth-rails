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
          before_action { |c| c.require_authorization(params) }
        end
      end

      protected

      def require_authorization(params)
        if Configuration.dev_mode
          ::Rails.logger.info "Omniauth::Rails: dev_mode is enabled. Skipping 'require_authorization'"
          return
        end

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
