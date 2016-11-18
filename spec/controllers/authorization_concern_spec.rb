# frozen_string_literal: true

require "rails_helper_for_engine"

RSpec.describe Omniauth::Rails::AuthorizationConcern do
  describe ".require_authorization" do
    context "require_authorization with no params" do
      controller(ApplicationController) do
        require_authorization

        def fake_action
          head :ok
        end

        private

        def real_authorized_method?
          true
        end
      end

      before do
        routes.draw do
          get "fake_action" => "anonymous#fake_action"
        end
      end

      context "an 'authorized?' method is defined" do
        before do
          class << controller
            private

            def authorized?
              real_authorized_method?
            end
          end
        end

        it "the 'authorized?' method is called" do
          expect(controller).to receive(:authenticated?).and_return(true)
          expect(controller).to receive(:real_authorized_method?).and_call_original
          get :fake_action
        end
      end

      context "an 'authorized?' method is NOT defined" do
        it "the 'authorized?' method is called" do
          expect(controller).to receive(:authenticated?).and_return(true)
          expect(controller).not_to receive(:real_authorized_method?)
          expect do
            get :fake_action
          end.to raise_error(NotImplementedError)
        end
      end
    end
  end
end
