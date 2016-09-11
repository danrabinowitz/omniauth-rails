# frozen_string_literal: true
module Omniauth
  module Rails
    module ApplicationHelper
      def authenticated?
        AuthenticationData.from_session(session).email.present?
      end

      def current_user
        AuthenticationData.from_session(session).email
      end
    end
  end
end
