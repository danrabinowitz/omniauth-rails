module Omniauth
  module Rails
    module RequireAuthentication
      extend ActiveSupport::Concern

      included do
        before_action :require_authentication
      end

      private

      def require_authentication
        if authentication_required? && !authenticated?
          redirect_to omniauth_rails.sign_in_url
        end
      end

      def authentication_required?
        true
      end

      def authenticated?
        AuthenticationData.from_session(session).email.present?
      end
    end
  end
end