# frozen_string_literal: true
module Omniauth
  module Rails
    class Engine < ::Rails::Engine
      require "omniauth"
      require "omniauth-google-oauth2"
      isolate_namespace Omniauth::Rails

      initializer "omniauth_rails.action_controller" do |_app|
        ActiveSupport.on_load :action_controller do
          helper Omniauth::Rails::ApplicationHelper
          if Configuration.include_concern_in_application_controller
            ::Rails.logger.info "Autoloading Omniauth::Rails::ControllersConcern into ActionController::Base"
            include Omniauth::Rails::ControllersConcern
          end
        end
      end

      config.generators do |g|
        g.test_framework :rspec, fixture: false
        g.assets false
        g.helper false
      end
    end
  end
end
