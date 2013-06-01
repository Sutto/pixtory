require 'spec_helper'

describe PersonSerializer do

  let(:person) do
    Person.create! name: "Test Name", avatar: "http://placekitten.com/300/300", push_token: SecureRandom.hex(32), location: "Perth, Australia"
  end

  let(:serializaiton_options) { {} }

  subject { described_class.new(person, serializaiton_options).serializable_hash }

  it 'should include the base details' do
    subject[:name].should   == person.name
    subject[:avatar].should == person.avatar
    subject[:location].should == person.location
  end

  it 'should have the id' do
    subject[:id].should be_present
    subject[:id].should == person.id
  end

  context 'as personal' do

    before { serializaiton_options[:personal] = true }

    it 'should include the tokens' do
      subject[:push_token].should be_present
      subject[:authentication_token].should be_present
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