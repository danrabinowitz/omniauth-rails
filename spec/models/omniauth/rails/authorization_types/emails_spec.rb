# frozen_string_literal: true

require "rails_helper_for_engine"
require_relative "../../../../../app/models/omniauth/rails/authorization_types/base"
require_relative "../../../../../app/models/omniauth/rails/authorization_types/emails"

RSpec.describe Omniauth::Rails::AuthorizationTypes::Emails do
  let(:email) { "foo@bar.com" }
  let(:emails) { %w(foo@bar.com baz@bar.com) }

  let(:subject) { Omniauth::Rails::AuthorizationTypes::Emails.new(email: email, value: emails) }

  describe "#authorized?" do
    context "a match" do
      it "returns true" do
        expect(subject.authorized?).to eq(true)
      end
    end

    context "a miss" do
      let(:email) { "foo99@bar.com" }

      it "returns false" do
        expect(subject.authorized?).to eq(false)
      end
    end
  end
end
