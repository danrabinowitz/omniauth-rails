# frozen_string_literal: true

require "rails_helper_for_engine"
require_relative "../../../../../app/models/omniauth/rails/authorization_types/base"
require_relative "../../../../../app/models/omniauth/rails/authorization_types/regex"

RSpec.describe Omniauth::Rails::AuthorizationTypes::Regex do
  let(:email) { "foo@bar.com" }
  let(:regex) { /\Afo\w@bar.com\z/i }

  let(:subject) { Omniauth::Rails::AuthorizationTypes::Regex.new(email: email, value: regex) }

  describe "#authorized?" do
    context "a match" do
      it "returns true" do
        expect(subject.authorized?).to eq(true)
      end
    end

    context "a miss" do
      let(:email) { "baz@bar.com" }

      it "returns false" do
        expect(subject.authorized?).to eq(false)
      end
    end
  end
end
