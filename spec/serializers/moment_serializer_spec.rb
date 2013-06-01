require 'spec_helper'

describe MomentSerializer do

  before do
    stub(Landmark).geocode.with_any_args { {city: "Perth", suburb: "Jolimont", street: "Currie St", coordinates: "POINT(5 10)"} }
  end

  let(:test_image) do
    path = Rails.root.join('spec', 'fixtures', 'test.jpg')
    File.open(path, 'rb')
  end

  after { test_image.close }

  let(:landmark) { Landmark.new location: "Test Location" }
  let(:moment)   { Moment.create! landmark: landmark, caption: "This is a Test Caption", image: test_image }

  subject { described_class.new(moment).serializable_hash }

  it 'should have the id' do
    subject[:id].should be_present
    subject[:id].should == moment.id
  end

  it 'should include full image details' do
    subject[:image].should be_present
    subject[:image][:full].should be_present
    subject[:image][:full][:url].should be_present
  end

  it 'should include primary image details' do
    subject[:image].should be_present
    subject[:image][:primary].should be_present
    subject[:image][:primary][:url].should be_present
  end

  it 'should include thumb image details' do
    subject[:image].should be_present
    subject[:image][:thumb].should be_present
    subject[:image][:thumb][:url].should be_present
  end

  it 'should include the caption' do
    subject[:caption].should be_present
    subject[:caption].should == moment.caption
  end

  it 'should include the landmark' do
    subject[:landmark].should be_present
    subject[:landmark].should == LandmarkSerializer.new(landmark).serializable_hash
  end

end