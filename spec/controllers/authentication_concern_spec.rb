# frozen_string_literal: true

require "rails_helper_for_engine"

RSpec.describe Omniauth::Rails::AuthenticationConcern do
  controller(ApplicationController) do
    require_authentication

    def fake_action
      head :ok
    end
  end

  before do
    routes.draw do
      get "fake_action" => "anonymous#fake_action"
    end
  end

  describe "require_authentication" do
    before { get :fake_action }

    it "redirects" do
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
        expect(response).to have_http_status(:success)
      end
    end
  end
end
