# frozen_string_literal: true

require_relative "../lib/omniauth/rails/version"

RSpec.describe Omniauth::Rails do
  # This silly spec ensures that the Omniauth::Rails::VERSION has code coverage
  it "has a version" do
    expect(Omniauth::Rails::VERSION).to be_a(String)
  end
end
