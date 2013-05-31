require 'spec_helper'

describe PersonSerializer do

  let(:person) do
    Person.create! name: "Test Name", avatar: "http://placekitten.com/300/300", push_token: SecureRandom.hex(32), location: "Perth, Australia"
  end

  it 'should include the base details' do
    serialized = PersonSerializer.new(person).serializable_hash
    serialized[:name].should   == person.name
    serialized[:avatar].should == person.avatar
    serialized[:location].should == person.location
  end

  context 'as personal' do

    it 'should include the tokens' do
      serialized = PersonSerializer.new(person, personal: true).serializable_hash
      serialized[:push_token].should be_present
      serialized[:authentication_token].should be_present
    end

  end

  context 'non personal' do

    it 'should not include tokens' do
      serialized = PersonSerializer.new(person, personal: false).serializable_hash
      serialized[:push_token].should be_nil
      serialized[:authentication_token].should be_nil
      serialized = PersonSerializer.new(person).serializable_hash
      serialized[:push_token].should be_nil
      serialized[:authentication_token].should be_nil
    end

  end

end