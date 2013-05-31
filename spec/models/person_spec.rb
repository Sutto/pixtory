require 'spec_helper'

describe Person do

  let(:token) { SecureRandom.hex 32 }

  it 'should require a push token' do
    person = Person.new
    person.should_not be_valid
    person.push_token = token
    person.should be_valid
  end

  it 'should generate an auth token' do
    person = Person.create! push_token: token
    person.authentication_token.should be_present
    other_person = Person.create! push_token: SecureRandom.hex(32)
    other_person.authentication_token.should be_present
    other_person.authentication_token.should_not == person.authentication_token
  end

  it 'should let you update the location'

end
