Omniauth::Rails::Engine.routes.draw do
  get '/sign_in', to: 'sessions#new', as: :sign_in
  get '/:provider/callback', to: 'sessions#create'
end
