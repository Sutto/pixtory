require 'spec_helper'

describe  MomentGeoJsonSerializer do

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

  subject { described_class.new(moment).serializable_hash }

  it 'should have the geometry correct' do
    subject[:geometry].should be_present
    subject[:geometry].should == {type: "Point", coordinates: [20.0, 25.0]}
  end

  it 'should have the correct type' do
    subject[:type].should == "Feature"
  end

  it 'should have properties' do
    subject[:properties].should be_present
  end

end
