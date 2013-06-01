require 'spec_helper'

describe Moment do

  before do
    stub(Landmark).geocode(anything) {{
      city:        'Perth',
      coordinates: 'POINT(10 20)',
      street:      'Test Street',
      suburb:      'Perth'
    }}
  end

  let(:landmark) { Landmark.create! location: 'Test Landmark' }

  let(:test_image) do
    path = Rails.root.join('spec', 'fixtures', 'test.jpg')
    File.open(path, 'rb')
  end

  after { test_image.close }

  subject do
    Moment.new image: test_image, location: 'Test Location', caption: 'This is a pretty picture'
  end

  it 'should automatically set landmark from location' do
    subject.location = nil
    subject.landmark.should be_nil
    mock(Landmark).from_location("Test Place") { landmark }
    subject.location = "Test Place"
    subject.landmark.should == landmark
  end

  it 'should get location from landmark' do
    subject.landmark = nil
    subject.location.should be_nil
    subject.landmark = landmark
    subject.location.should == landmark.location
  end

  it 'should require a landmark' do
    subject.landmark = nil
    subject.should_not be_valid
    subject.should have_at_least(1).errors_on(:landmark)
    subject.landmark = landmark
    subject.valid?
    subject.should have(0).errors_on(:landmark)
  end

  it 'should require a caption' do
    subject.caption = nil
    subject.should_not be_valid
    subject.should have_at_least(1).errors_on(:caption)
    subject.caption = 'Test Caption'
    subject.valid?
    subject.should have(0).errors_on(:caption)
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
