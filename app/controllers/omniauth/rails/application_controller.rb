# frozen_string_literal: true
module Omniauth
  module Rails
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception
    end
  end
end
