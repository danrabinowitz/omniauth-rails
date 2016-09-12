# frozen_string_literal: true
module Omniauth
  module Rails
    module AuthorizationTypes
      class Domains < Base
        def authorized?
          domains.any? { |domain| email_domain.casecmp(domain).zero? }
        end

        private

        def email_domain
          @email_domain ||= email.split("@").last.to_s
        end

        def domains
          value
        end
      end
    end
  end
end
