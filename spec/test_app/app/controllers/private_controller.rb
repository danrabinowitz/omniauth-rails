# frozen_string_literal: true

class PrivateController < ApplicationController
  include Omniauth::Rails::RequireAuthentication

  def show
    head :ok
  end
end
