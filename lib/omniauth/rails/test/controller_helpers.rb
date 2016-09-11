module Omniauth
  module Rails
    module Test
      module ControllerHelpers
        def sign_in(email)
          session["OmniauthRailsAuthData"] = {"email" => email}
        end
      end
    end
  end
end
