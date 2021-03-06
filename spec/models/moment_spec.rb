require 'spec_helper'

describe Moment do

  let(:test_image) do
    path = Rails.root.join('spec', 'fixtures', 'test.jpg')
    File.open(path, 'rb')
  end

  after { test_image.close }

  subject do
    Moment.new image: test_image, location: 'Test Location', caption: 'This is a pretty picture', coordinates: [20, 10]
  end

  it 'should set coordinates from long / lat pair' do
    subject.coordinates = [45, 65]
    subject.coordinates.should be_present
    subject.coordinates.lon.should be_within(0.001).of(65)
    subject.coordinates.lat.should be_within(0.001).of(45)
  end

  context 'validations' do

    it 'should require a caption' do
      subject.caption = nil
      subject.should_not be_valid
      subject.should have_at_least(1).errors_on(:caption)
      subject.caption = 'Test Caption'
      subject.valid?
      subject.should have(0).errors_on(:caption)
    end

    it 'should require a location' do
      subject.location = nil
      subject.should_not be_valid
      subject.should have_at_least(1).errors_on(:location)
      subject.location = 'Test Location'
      subject.valid?
      subject.should have(0).errors_on(:location)
    end

    it 'should require a coordinates' do
      subject.coordinates = nil
      subject.should_not be_valid
      subject.should have_at_least(1).errors_on(:coordinates)
      subject.coordinates = [10, 10]
      subject.valid?
      subject.should have(0).errors_on(:coordinates)
    end

    it 'should require an image' do
      subject.remove_image!
      subject.should_not be_valid
      subject.should have_at_least(1).errors_on(:image)
      subject.image = test_image
      subject.valid?
      subject.should have(0).errors_on(:image)
    end

  end

  context 'the title' do

    it 'should include the location in the title' do
      subject.title.should be_present
      subject.location.should be_present
      subject.title.should include subject.location
    end

    it 'should include the formatted timestamp in the title' do
      subject.title.should be_present
      subject.formatted_timestamp.should be_present
      subject.title.should include subject.formatted_timestamp
    end

  end

  context 'the formatted timestamp' do

    it 'shold be unknown without a date' do
      moment = Moment.new captured_at: nil
      moment.formatted_timestamp.should == "unknown"
    end

    it 'should return circa dates correctly' do
      moment = Moment.new captured_at: Date.new(1943), approximate_date: true
      moment.formatted_timestamp.should == "ca. 1943"
    end

    it 'should return specific years correctly' do
      moment = Moment.new captured_at: Date.new(1943), approximate_date: false
      moment.formatted_timestamp.should == "1943"
    end

  end

  context 'setting the image' do

    enable_processing_on ImageUploader

    it 'should automatically set the width and height from the image' do
      moment = Moment.new location: 'Test Location', caption: 'This is a pretty picture', coordinates: [20, 10]
      moment.width.should be_nil
      moment.height.should be_nil
      moment.image = test_image
      moment.save!
      moment.width.should be_present
      moment.height.should be_present
    end

  end

end
