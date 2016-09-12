# frozen_string_literal: true
module Omniauth
  module Rails
    module Flash
      extend ActiveSupport::Concern

      def set_url_to_return_to_after_authentication
        # TODO: Sanitize these urls, to avoid phishing attacks
        # See https://www.owasp.org/index.php/Unvalidated_Redirects_and_Forwards_Cheat_Sheet
        flash[:url_to_return_to_after_authentication] =
          # url_to_return_to_after_authentication_from_params ||
          url_to_return_to_after_authentication_from_flash ||
          # url_to_return_to_after_authentication_from_referer ||
          default_url_to_return_to_after_authentication
      end

      private

      # def url_to_return_to_after_authentication_from_params
      #   return nil unless allow_url_to_return_to_after_authentication_from_params?
      #   params[:return_to]
      # end

      # def allow_url_to_return_to_after_authentication_from_params?
      #   false
      # end

      def url_to_return_to_after_authentication_from_flash
        flash[:url_to_return_to_after_authentication]
      end

      # def url_to_return_to_after_authentication_from_referer
      #   return nil unless allow_url_to_return_to_after_authentication_from_referer?
      #   request.referer
      # end

      # def allow_url_to_return_to_after_authentication_from_referer?
      #   false
      # end

      def default_url_to_return_to_after_authentication
        Configuration.authenticated_root
      end
    end
  end
end
