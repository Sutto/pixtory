require 'open-uri'
require 'csv'
require 'date'

class DumpImporter

  def self.import!(path)
    File.open(path, 'r') do |f|
      new(f).import
    end
  end

  def self.import_url!(url)
    reader = open(url)
    new(reader).import
  ensure
    reader.close
  end

  def self.auto_import!
    if (key = ENV['SPREADSHEET_KEY']).present?
      url = "https://spreadsheets.google.com/pub?key=#{key}&output=csv"
      import_url! url
    end
  end

  attr_reader :io

  def initialize(io)
    @io = io
  end

  def each_row
    CSV.open io, headers: true do |csv|
      csv.each { |row| yield row }
    end
  end

  def import
    each_row do |row|
      next if row["Picture URL"].blank? or row['Geo'].blank? or row["Address"].blank?
      begin
        puts "Importing row: #{row['UID']}"
        item = Moment.from_source(:csv, row['UID'])
        item.attributes = {
          source_image_url: row['Picture URL'],
          caption:          row['Caption'],
          location:         row['Address'],
          coordinates:      row['Geo'].split(","),
          source_url:       row['Source of Picture'],
          captured_at:      Date.new(*row['Date'].split("/").map(&:to_i).reverse),
          approximate_date: (row['Circa'].to_s.downcase.strip == 'y'),
          description:      row['Description'],
          license:          "cc by-nc-sa 3.0",
          source_name:      "State Library of Western Australia"
        }
        if item.image.blank? || item.source_image_url_changed?
          item.remote_image_url = row['Picture URL']
        end
        item.save!
      rescue => e
        STDERR.puts "Error on #{row['UID']}: #{e.message} (#{e.class.name})"
      end
    end
  end

end
