module Omniauth
  module Rails
    module Test
      module RequestHelpers
        def sign_in(email)
          fake_data_store = double
          allow(fake_data_store).to receive(:get).with("email").and_return(email)
          allow(AuthenticationDataStore).to receive(:new).and_return(fake_data_store)
        end
      end
    end
  end
end
