module Omniauth
  module Rails
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
