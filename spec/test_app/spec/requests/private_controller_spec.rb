# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../", __FILE__)
require "rails_helper"

RSpec.describe PrivateController do
  describe "#show" do
    context "user is not authenticated" do
      it "redirects to the sign_in page" do
        get "/private"
        expect(response).to redirect_to("/auth/sign_in")
      end
    end

    context "user is authenticated" do
      before do
        sign_in("foo@bar.com")
      end

      it "responds with a 200" do
        get "/private"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
