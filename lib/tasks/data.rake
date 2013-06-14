namespace :data do

  desc "Autoimports the data from the google doc"
  task auto_import: :environment do
    puts "Fetching from the CSV"
    DumpImporter.auto_import!
    puts "DONE"
  end

  desc "Generates a dump of all sources"
  task dump: :environment do
    require 'logger'
    require 'dump_generator'
    logger = Logger.new STDOUT
    generator = DumpGenerator.new DumpGenerator.default_storage, logger
    generator.dump_all
  end

end
