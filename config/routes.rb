# frozen_string_literal: true
Omniauth::Rails::Engine.routes.draw do
  get "/sign_in", to: "sessions#new", as: :sign_in
  delete "/sign_out", to: "sessions#destroy", as: :sign_out
  get "/:provider/callback", to: "sessions#create"
end
