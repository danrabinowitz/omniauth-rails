# frozen_string_literal: true
module Omniauth
  module Rails
    module Test
      module ControllerHelpers
        def sign_in(email)
          session["OmniauthRailsAuthData"] = { "email" => email }
        end

        def authenticated?
          session["OmniauthRailsAuthData"].present? &&
            session["OmniauthRailsAuthData"]["email"].present?
        end
      end
    end
  end
end
