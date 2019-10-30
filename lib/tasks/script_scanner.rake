require 'utility/script_scanner'


namespace :script_scanner do
  desc "Populate scripts for all movies"
  task :populate_all_scripts do
    scanner = Utility::ScriptScanner.new
    scanner.populate_all_scripts
  end
end

