# frozen_string_literal: true
module Omniauth
  module Rails
    module RequireAuthentication
      extend ActiveSupport::Concern

      included do
        before_action :require_authentication
      end

      private

      def require_authentication
        redirect_to omniauth_rails.sign_in_url if authentication_required? && !authenticated?
      end

      def authentication_required?
        true
      end

      # TODO: This is duplicated in ApplicationHelper
      def authenticated?
        authentication_session.authenticated?
      end

      # TODO: This is duplicated in ApplicationHelper
      def authentication_session
        AuthenticationSession.new(session)
      end
    end
  end
end
