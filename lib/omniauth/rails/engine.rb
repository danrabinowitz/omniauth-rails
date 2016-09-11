module Omniauth
  module Rails
    class Engine < ::Rails::Engine
      require 'omniauth'
      require 'omniauth-google-oauth2'
      isolate_namespace Omniauth::Rails

      config.generators do |g|
        g.test_framework :rspec, fixture: false
        g.assets false
        g.helper false
      end
    end
  end
end
