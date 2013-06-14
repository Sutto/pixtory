require 'nokogiri'
require 'set'

class KmlFeedGenerator

  attr_reader :moments

  def initialize(moments = [])
    @moments = moments.to_set
  end

  def render
    make_document.to_xml
  end

  def self.render(moments)
    new(moments).render
  end

  def make_builder(&block)
    Nokogiri::XML::Builder.new(encoding: 'UTF-8', &block)
  end

  def add_moment_to_builder(builder, moment)
    builder.Placemark do
      builder.name moment.title
      builder.description "This is where things wil go..."
      builder.Point do
        builder.coordinates "#{moment.coordinates.lon},#{moment.coordinates.lat}"
      end
    end
  end

  def make_document
    make_builder do |builder|
      builder.kml xmlns: "http://www.opengis.net/kml/2.2" do
        builder.Document do
          moments.each do |moment|
            add_moment_to_builder builder, moment
          end
        end
      end
    end
  end

end
