Rails.application.routes.draw do
  get '/public', to: 'public#show'
  get '/private', to: 'private#show'

  mount Omniauth::Rails::Engine => "/omniauth-rails"
end
