# frozen_string_literal: true
module Omniauth
  module Rails
    module Flash
      extend ActiveSupport::Concern

      def set_url_to_return_to_after_authentication
        # Use caution when setting these urls.
        # There are phishing risks associated with redirection, as described here:
        # See https://www.owasp.org/index.php/Unvalidated_Redirects_and_Forwards_Cheat_Sheet
        flash[:url_to_return_to_after_authentication] =
          url_to_return_to_after_authentication_from_flash ||
          default_url_to_return_to_after_authentication
      end

      private

      def url_to_return_to_after_authentication_from_flash
        flash[:url_to_return_to_after_authentication]
      end

      def default_url_to_return_to_after_authentication
        Configuration.authenticated_root
      end
    end
  end
end
