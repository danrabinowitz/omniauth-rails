# frozen_string_literal: true

class PrivateController < ApplicationController
  # TODO: Automatically include this concern in ApplicationController, based on a config option
  include Omniauth::Rails::ControllersConcern
  require_authorization domains: %w(bar.com)

  def show
  end
end
