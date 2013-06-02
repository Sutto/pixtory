require 'spec_helper'

describe MomentsController do

  let(:test_image) do
    path = Rails.root.join('spec', 'fixtures', 'test.jpg')
    File.open(path, 'rb')
  end
  after { test_image.close }
  let!(:moment) do
    Moment.create! image: test_image, location: 'Test Location', caption: 'This is a pretty picture', coordinates: [20, 10]
  end

  describe 'index' do

    it 'should work with non random' do
      get :index, lat: 20, lng: 10
      response.should be_successful
    end

    it 'should work with random' do
      get :index
      response.should be_successful
    end

  end

  describe 'show' do

    it 'should work' do
      get :show, id: moment.to_param
      response.should be_successful
    end

  end

end
