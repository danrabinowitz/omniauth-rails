# frozen_string_literal: true
module Omniauth
  module Rails
    class Configuration
      ATTRIBUTES = %i(
        authenticated_root include_concern_in_application_controller
        unauthenticated_root session_duration logger
        dev_mode
      ).freeze

      @session_duration = 1.hour
      @logger = ::Rails.logger

      class << self
        attr_accessor(*ATTRIBUTES)
      end
    end
  end
end
