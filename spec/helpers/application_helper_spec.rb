# frozen_string_literal: true

require "rails_helper_for_engine"

RSpec.describe Omniauth::Rails::ApplicationHelper do
  describe ".authenticated_email" do
    context "authenticated user" do
      let(:email) { "foo@bar.com" }

      before do
        expect(helper).to receive(:authenticated?).and_return(true)

        fake_session = {}
        data_store = Omniauth::Rails::AuthenticationDataStore.new(fake_session)
        data_store.set("email", email)
        expect(Omniauth::Rails::AuthenticationDataStore).to receive(:new).and_return(data_store)

        expect(helper).to receive(:authentication_session).and_return(authentication_session)
      end

      it "returns the email address" do
        expect(helper.authenticated_email).to eq(email)
      end
    end

    context "unauthenticated user in dev_mode" do
      before do
        expect(helper).to receive(:authenticated?).and_return(false)

        @original_value_dev_mode = Omniauth::Rails::Configuration.dev_mode
        Omniauth::Rails::Configuration.dev_mode = true
      end

      after do
        Omniauth::Rails::Configuration.dev_mode = @original_value_dev_mode
      end

      it "the correct string" do
        expect(helper.authenticated_email).to eq("[not logged in - dev mode]")
      end
    end
  end
end
