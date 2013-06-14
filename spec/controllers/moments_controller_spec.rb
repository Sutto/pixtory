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

    context 'scoped by location' do

      it 'should work with json' do
        get :index, format: 'json', lat: 20, lng: 10
        response.should be_successful
        response.content_type.should == 'application/json'
      end

      it 'should work with geojson' do
        get :index, format: 'geojson', lat: 20, lng: 10
        response.should be_successful
        response.content_type.should == 'application/json'
      end

      it 'should work with kml' do
        get :index, format: 'kml', lat: 20, lng: 10
        response.should be_successful
        response.content_type.should == 'application/vnd.google-earth.kml+xml'
      end

    end

    context 'with the default scope' do

      it 'should work with json' do
        get :index, format: 'json'
        response.should be_successful
        response.content_type.should == 'application/json'
      end

      it 'should work with geojson' do
        get :index, format: 'geojson'
        response.should be_successful
        response.content_type.should == 'application/json'
      end

      it 'should work with kml' do
        get :index, format: 'kml'
        response.should be_successful
        response.content_type.should == 'application/vnd.google-earth.kml+xml'
      end

    end

  end

  describe 'show' do

    it 'should work as json' do
      get :show, id: moment.to_param, format: 'json'
      response.should be_successful
      response.content_type.should == 'application/json'
    end

    it 'should work as geojson' do
      get :show, id: moment.to_param, format: 'geojson'
      response.should be_successful
      response.content_type.should == 'application/json'
    end

    it 'should work as kml' do
      get :show, id: moment.to_param, format: 'kml'
      response.should be_successful
      response.content_type.should == 'application/vnd.google-earth.kml+xml'
    end

  end

end
