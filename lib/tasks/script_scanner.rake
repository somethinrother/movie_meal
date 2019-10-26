require 'utility/script_scanner'


namespace :script_scanner do
  desc "Populate scripts for all movies"
  task :populate_all_scripts do
    scanner = Utility::ScriptScanner.new
    scanner.populate_all_scripts
  end

  desc "find all ingredients in all movie scripts"
  task :scan_all_ingredients do
    scanner = Utility::ScriptScanner.new
    scanner.scan_all_scripts
  end
end

