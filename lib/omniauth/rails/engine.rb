module Omniauth
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Omniauth::Rails
    end
  end
end
