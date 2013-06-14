require 'spec_helper'

describe KmlFeedGenerator do

  let(:test_image) do
    path = Rails.root.join('spec', 'fixtures', 'test.jpg')
    File.open(path, 'rb')
  end

  after { test_image.close }

  let(:moment) do
    Moment.create!({
      location:         "Perth, Australia",
      coordinates:      [25.0, 20.0],
      caption:          "This is a Test Caption",
      image:            test_image,
      width:            100,
      height:           200,
      captured_at:      Date.new(2000),
      approximate_date: false,
      source_url:       "http://example.com/test",
      description:      "TEST"
    })
  end


  it 'should work with a single moment' do
    rendered = KmlFeedGenerator.render [moment]
    rendered.should be_present
    Nokogiri::XML(rendered).should be_present
  end

  it 'should work with several moments' do
    rendered = KmlFeedGenerator.render [moment, moment, moment]
    rendered.should be_present
    Nokogiri::XML(rendered).should be_present
  end

end
