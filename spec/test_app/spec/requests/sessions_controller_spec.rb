# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../", __FILE__)
require "rails_helper"

RSpec.describe Omniauth::Rails::SessionsController do
  describe "#new" do
    it "redirects to the OmniAuth provider endpoint" do
      get "/auth/sign_in"
      expect(response).to redirect_to("/auth/google_oauth2")
    end
  end

  describe "#destroy" do
    context "an authenticated user" do
      before do
        sign_in("foo@bar.com")
      end

      it "logs the user out" do
        expect(authenticated?).to eq(true)
        delete "/auth/sign_out"
        expect(authenticated?).to eq(false)
      end
    end
  end

  describe "#create" do
    context "a response with invalid CSRF" do
      around(:each) do |example|
        OmniAuth.config.mock_auth[:google_oauth2] = :csrf_detected
        example.run
        OmniAuth.config.mock_auth[:google_oauth2] = nil
      end

      it "redirects to /auth/failure?message=csrf_detected&strategy=google_oauth2" do
        get "/auth/google_oauth2/callback"
        expect(response).to redirect_to("/auth/failure?message=csrf_detected&strategy=google_oauth2")
      end
    end

    context "a response with invalid credentials" do
      around(:each) do |example|
        OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
        example.run
        OmniAuth.config.mock_auth[:google_oauth2] = nil
      end

      it "redirects to /auth/failure?message=invalid_credentials&strategy=google_oauth2" do
        get "/auth/google_oauth2/callback"
        expect(response).to redirect_to("/auth/failure?message=invalid_credentials&strategy=google_oauth2")
      end
    end

    context "a valid auth response" do
      it "redirects to Configuration.authenticated_root" do
        get "/auth/google_oauth2/callback"
        expect(response).to redirect_to(Omniauth::Rails::Configuration.authenticated_root)
      end
    end
  end
end
