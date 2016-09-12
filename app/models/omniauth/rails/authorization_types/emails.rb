# frozen_string_literal: true
module Omniauth
  module Rails
    module AuthorizationTypes
      class Emails < Base
        def authorized?
          emails.any? { |allowed_email| allowed_email.to_s.casecmp(email).zero? }
        end

        private

        def emails
          value
        end
      end
    end
  end
end
