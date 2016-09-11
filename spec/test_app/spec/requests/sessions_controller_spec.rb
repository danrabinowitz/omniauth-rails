# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../', __FILE__)
require "rails_helper"

RSpec.describe Omniauth::Rails::SessionsController do
  describe "#new" do
    it "redirects to the OmniAuth provider endpoint" do
      get "/auth/sign_in"
      expect(response).to redirect_to("/auth/google_oauth2")
    end
  end

  describe "#create" do
    let(:email) { "foo@bar.com" }
    let(:auth_response) { OpenStruct.new(info: OpenStruct.new(email: email) ) }
    let(:env) { Hash["omniauth.auth" => auth_response] }

    context "a valid auth response" do
      it "redirects to /" do
        get "/auth/google_oauth2/callback", env: env
        expect(response).to redirect_to("/")
      end
    end
  end
end
