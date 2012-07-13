require 'spec_helper'

describe GeoController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'location'" do
    it "returns http success" do
      get 'location'
      response.should be_success
    end
  end

  describe "GET 'locateme'" do
    it "returns http success" do
      get 'locateme'
      response.should be_success
    end
  end

end
