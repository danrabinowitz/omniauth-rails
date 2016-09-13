# frozen_string_literal: true
module Omniauth
  module Rails
    module AuthenticationConcern
      extend ActiveSupport::Concern

      included do
        include Omniauth::Rails::ApplicationHelper
      end

      module ClassMethods
        private

        def require_authentication
          before_action :require_authentication
        end
      end

      private

      def require_authentication
        if Configuration.dev_mode
          ::Rails.logger.info "Omniauth::Rails: dev_mode is enabled. Skipping 'require_authentication'"
          return
        end

        redirect_to_sign_in_url unless authenticated?
      end

      def redirect_to_sign_in_url
        flash[:url_to_return_to_after_authentication] = request.original_url
        redirect_to omniauth_rails.sign_in_url
      end
    end
  end
end
