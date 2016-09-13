# frozen_string_literal: true
Rails.application.routes.draw do
  get "/public", to: "public#show"
  get "/private", to: "private#show"

  # TODO: Allow the mounting to be automatic
  mount Omniauth::Rails::Engine => OmniAuth.config.path_prefix
end
