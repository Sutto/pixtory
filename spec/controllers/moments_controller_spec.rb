require 'spec_helper'

describe MomentsController do

  describe 'index' do


    let(:test_image) do
      path = Rails.root.join('spec', 'fixtures', 'test.jpg')
      File.open(path, 'rb')
    end
    after { test_image.close }
    let!(:moment) do
      Moment.new image: test_image, location: 'Test Location', caption: 'This is a pretty picture', coordinates: [20, 10]
    end

    it 'should work' do
      get :index, lat: 20, lng: 10
      response.should be_successful
    end

  end

end
