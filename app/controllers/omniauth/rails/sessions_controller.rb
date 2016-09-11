# frozen_string_literal: true
module Omniauth
  module Rails
    class SessionsController < ApplicationController
      # GET /sign_in
      def new
        # TODO: Maybe store some kind of "return_to" url. Maybe in a session.
        # TODO: Do we need to clear the session first?
        redirect_to omniauth_route
      end

      # GET /:provider/callback
      def create
        persist_authentication_data
        redirect_to url_to_return_to_after_authentication
      end

      private

      def omniauth_route
        OmniAuthRouteBuilder.new.route
      end

      def url_to_return_to_after_authentication
        "/"
      end

      def persist_authentication_data
        AuthenticationData.from_request(request).persist(session)
      end
    end
  end
end
