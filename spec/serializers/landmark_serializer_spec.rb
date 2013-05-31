require 'spec_helper'

describe LandmarkSerializer do

  before do
    stub(Landmark).geocode.with_any_args { {city: "Perth", suburb: "Jolimont", street: "Currie St", coordinates: "POINT(5 10)"} }
  end

  let(:landmark) { Landmark.new location: "Test Location" }

  subject { LandmarkSerializer.new(landmark).serializable_hash }

  it 'should serialize the basic attributes' do
    subject[:location].should == landmark.location
    subject[:city].should == landmark.city
    subject[:street].should == landmark.street
    subject[:suburb].should == landmark.suburb
  end

  it 'should serialize the coordinates' do
    subject[:coordinates].should == {lat: 10.0, lng: 5.0}
  end

end