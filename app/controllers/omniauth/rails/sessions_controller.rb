# frozen_string_literal: true
module Omniauth
  module Rails
    class SessionsController < ApplicationController
      include Omniauth::Rails::Flash

      # GET /sign_in
      def new
        # Set a flash variable, so we know where to go after a successful authentication.
        set_url_to_return_to_after_authentication

        # If we are already authenticated, do not attempt to authenticate again.
        # Instead, redirect to where we would go after authentication
        redirect_to flash[:url_to_return_to_after_authentication] and return if authenticated?

        redirect_to omniauth_route
      end

      # DELETE /sign_out
      def destroy
        authentication_session.reset

        if url_to_return_to_after_sign_out.present?
          redirect_to url_to_return_to_after_sign_out
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

      def url_to_return_to_after_sign_out
        Configuration.unauthenticated_root
      end

      # TODO: This is duplicated in ApplicationHelper
      def authenticated?
        authentication_session.authenticated?
      end

      def authentication_request
        AuthenticationRequest.new(request)
      end

      # TODO: This is duplicated in ApplicationHelper
      def authentication_session
        AuthenticationSession.new(session)
      end
    end
  end
end
