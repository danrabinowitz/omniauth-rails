# frozen_string_literal: true

class PrivateController < ApplicationController
  require_authorization domains: %w(bar.com)

  def show
  end
end
