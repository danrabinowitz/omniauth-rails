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
        if authentication_required? && !authenticated?
          flash[:url_to_return_to_after_authentication] = request.original_url
          redirect_to omniauth_rails.sign_in_url
        end
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
