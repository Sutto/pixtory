require 'spec_helper'

describe RootController do

  describe 'the index action' do

    it 'should work as json' do
      get :index, format: 'json'
      response.should be_successful
    end

    it 'should work as html' do
      get :index, format: 'html'
      response.should be_redirect
      response.should redirect_to explore_url
    end

  end

end
