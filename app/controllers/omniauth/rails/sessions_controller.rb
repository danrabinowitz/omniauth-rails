# frozen_string_literal: true
module Omniauth
  module Rails
    class SessionsController < ::Omniauth::Rails::ApplicationController
      include Omniauth::Rails::ApplicationHelper
      include Omniauth::Rails::Flash

      # GET /sign_in
      def new
        # Set a flash variable, so we know where to go after a successful authentication.
        set_url_to_return_to_after_authentication

        # If we are already authenticated, do not attempt to authenticate again.
        # Instead, redirect to where we would go after authentication
        if authenticated?
          redirect_to flash[:url_to_return_to_after_authentication]
        else
          redirect_to omniauth_route
        end
      end

      # DELETE /sign_out
      def destroy
        authentication_session.reset

        if Configuration.unauthenticated_root.present?
          redirect_to Configuration.unauthenticated_root
        else
          render layout: false
        end
      end

      # GET /:provider/callback
      def create
        persist_authentication_data
        redirect_to flash[:url_to_return_to_after_authentication] ||
                    default_url_to_return_to_after_authentication
      end

      private

      def omniauth_route
        OmniAuthRouteBuilder.new.route
      end

      def persist_authentication_data
        authentication_request.persist(authentication_session)
      end

      def authentication_request
        AuthenticationRequest.new(request)
      end
    end
  end
end
