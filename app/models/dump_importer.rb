require 'open-uri'
require 'csv'

class DumpImporter

  def self.import!(path)
    File.open(path, 'r') do |f|
      new(f).import
    end
  end

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def each_row
    CSV.open(file, headers: true) do |csv|
      csv.each do |row|
        yield row if block_given?
      end
    end
  end

  def import
    each_row do |row|
      next if row["Picture URL"].blank?
      begin
        item = Moment.from_source(:csv, row['UID'])
        item.attributes = {
          remote_image_url: row['Picture URL'],
          caption:          row['Caption'],
          location:         row['Geo']
        }
        item.save!
      rescue => e
        STDERR.puts "Error on #{row['UID']}: #{e.message} (#{e.class.name})"
      end
    end
  end

end