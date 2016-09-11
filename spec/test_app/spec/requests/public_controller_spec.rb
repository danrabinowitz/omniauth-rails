# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../', __FILE__)
require "rails_helper"

RSpec.describe PublicController do
  describe "#show" do
    it "responds with a 200" do
      get "/public"
      expect(response).to have_http_status(:success)
    end
  end
end
