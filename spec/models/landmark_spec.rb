require 'spec_helper'

describe Landmark do

  let(:fake_result) do
    {
      city:        'Perth',
      coordinates: 'POINT(10 20)',
      street:      'Test Street',
      suburb:      'Perth'
    }
  end

  before do
    stub(Landmark).geocode(anything) { fake_result }
  end

  it 'should automatically geocode the location on assignment' do
    subject.city.should be_nil
    subject.coordinates.should be_nil
    subject.street.should be_nil
    subject.suburb.should be_nil
    mock(Landmark).geocode('fake address') { fake_result }
    subject.location = 'fake address'
    subject.city.should == fake_result[:city]
    subject.street.should == fake_result[:street]
    subject.suburb.should == fake_result[:suburb]
    subject.coordinates.lat.should == 20.0
    subject.coordinates.lon.should == 10.0
  end

  it 'should let you look up the location from the point' do
    item = Landmark.from_location 'Test Location'
    item.location.should == 'Test Location'
    second = Landmark.from_location 'Test Location'
    second.should == item
  end

  it 'should let you find ordered from a location'

end
