# frozen_string_literal: true

require "rails_helper_for_engine"

RSpec.describe Omniauth::Rails::Configurator do
  let(:required_data) do
    {
      "unauthenticated_root" => "/",
      "authenticated_root" => "/",
      "providers" => {
        "google_oauth2" => {
          "client_id" => 1,
          "client_secret" => 1,
        },
      },
    }
  end

  let(:data) { required_data }
  let(:configurator) { Omniauth::Rails::Configurator.new(data) }

  describe "#configure" do
    context "dev_mode is true" do
      let(:data) { required_data.merge("dev_mode" => true) }

      context "dev_mode is allowed" do
        after do
          # Put it back to the initial value
          Omniauth::Rails::Configuration.dev_mode = false
        end

        it "sets Configuration.dev_mode = true" do
          expect(configurator).to receive(:configure_providers)
          expect(::Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("development"))

          configurator.configure
          expect(Omniauth::Rails::Configuration.dev_mode).to eq(true)
        end
      end
    end
  end
end
