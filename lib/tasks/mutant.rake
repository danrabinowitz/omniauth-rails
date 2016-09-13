# frozen_string_literal: true

desc "Run mutant"
task :mutant do
  cmd = "(cd #{Rails.root}; RAILS_ENV=test bundle exec mutant -r ./config/environment --use rspec " \
        "Omniauth::Rails::* ) 2>&1 | tee #{Rails.root}/../../coverage/mutant.out"
  system(cmd)
end
