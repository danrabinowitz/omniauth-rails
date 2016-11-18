# frozen_string_literal: true
module Omniauth
  module Rails
    module AuthorizationConcern
      def self.included(klass)
        klass.extend ClassMethods
      end

      module ClassMethods
        private

        def require_authorization(params = {})
          before_action { |c| c.omniauth_rails_require_authorization(params) }
        end
      end

      protected

      def omniauth_rails_require_authorization(params)
        if Configuration.dev_mode
          ::Rails.logger.info "Omniauth::Rails: dev_mode is enabled. Skipping 'require_authorization'"
          return
        end

        require_authentication # Require authentication before authorization.
        return if performed?
        omniauth_rails_render_403_forbidden unless omniauth_rails_authorized_with_params?(params)
      end

      private

      def omniauth_rails_authorized_with_params?(params)
        if params.present?
          omniauth_rails_authorization_checker_authorized?(params)
        else
          omniauth_rails_authorized?
        end
      end

      def omniauth_rails_authorized?
        raise(
          NotImplementedError,
          "Using 'require_authorization' without arguments requires a method named 'authorized?'.",
        ) unless authorized_method_defined?
        authorized?
      end

      def authorized_method_defined?
        respond_to?(:authorized?, true) && method(:authorized?).arity.zero?
      end

      def omniauth_rails_authorization_checker_authorized?(params)
        AuthorizationChecker.new(email: authenticated_email, params: params).authorized?
      end

      def omniauth_rails_render_403_forbidden
        render "omniauth/rails/forbidden", status: :forbidden, layout: false
      end
    end
  end
end
