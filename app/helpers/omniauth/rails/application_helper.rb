# frozen_string_literal: true
module Omniauth
  module Rails
    module ApplicationHelper
      delegate :authenticated?, to: :authentication_session

      def authenticated_email
        authentication_session.email
      end

      def authentication_session
        AuthenticationSession.new(session)
      end
    end
  end
end
