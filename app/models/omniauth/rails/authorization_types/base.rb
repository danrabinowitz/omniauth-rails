# frozen_string_literal: true
module Omniauth
  module Rails
    module AuthorizationTypes
      class Base
        def initialize(email:, value:)
          @email = email
          @value = value
        end

        private

        attr_reader :email, :value
      end
    end
  end
end
