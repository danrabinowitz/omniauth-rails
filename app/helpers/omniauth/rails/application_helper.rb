# frozen_string_literal: true
module Omniauth
  module Rails
    module ApplicationHelper
      delegate :authenticated?, to: :authentication_session

      def authenticated_email
        if authenticated?
          authentication_session.email
        elsif Configuration.dev_mode
          "[not logged in - dev mode]"
        end
      end

      def authentication_session
        AuthenticationSession.new(session)
      end
    end
  end
end
