require 'spec_helper'

describe RootController do

  describe 'the index action' do

    it 'should work' do
      get :index
      response.should be_successful
    end

  end

end
