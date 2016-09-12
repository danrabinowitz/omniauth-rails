# frozen_string_literal: true

class PrivateController < ApplicationController
  include Omniauth::Rails::RequireAuthorization
  require_authorization domains: %w(bar.com)

  def show
  end
end
