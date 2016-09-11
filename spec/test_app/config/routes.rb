Rails.application.routes.draw do
  mount Omniauth::Rails::Engine => "/omniauth-rails"
end
