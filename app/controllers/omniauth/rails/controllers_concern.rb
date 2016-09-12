# frozen_string_literal: true
module Omniauth
  module Rails
    module ControllersConcern
      def self.included(klass)
        klass.include Omniauth::Rails::AuthenticationConcern
        klass.include Omniauth::Rails::AuthorizationConcern
      end
    end
  end
end
