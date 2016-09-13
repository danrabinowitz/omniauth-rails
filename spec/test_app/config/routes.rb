# frozen_string_literal: true
Rails.application.routes.draw do
  get "/public", to: "public#show"
  get "/private", to: "private#show"
end
