namespace :data do

  desc "Autoimports the data from the google doc"
  task auto_import: :environment do
    puts "Fetching from the CSV"
    DumpImporter.auto_import!
    puts "DONE"
  end

end