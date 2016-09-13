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

      context "dev_mode is enabled" do
        around(:each) do |example|
          original_value = Omniauth::Rails::Configuration.dev_mode
          Omniauth::Rails::Configuration.dev_mode = true
          example.run
          Omniauth::Rails::Configuration.dev_mode = original_value
        end

        it "responds with a 200" do
          get "/private"
          expect(response).to have_http_status(:success)
        end
      end
    end

    context "user is authenticated" do
      context "user is authorized" do
        before do
          sign_in("foo@bar.com")
        end

        it "responds with a 200" do
          get "/private"
          expect(response).to have_http_status(:success)
        end
      end

      context "not authorized" do
        before do
          sign_in("foo@baz.com") # This domain is not in the allowed list of domains.
        end

        it "responds with a 403:forbidden" do
          get "/private"
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
