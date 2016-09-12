# frozen_string_literal: true
module Omniauth
  module Rails
    module AuthorizationTypes
      class Regex < Base
        def authorized?
          !regex.match(email).nil?
        end

        private

        def regex
          value
        end
      end
    end
  end
end
