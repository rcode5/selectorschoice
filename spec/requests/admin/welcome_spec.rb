require 'spec_helper'

describe "Welcome" do
  describe "GET /" do
    it "returns a success" do
      get '/'
      response.status.should be(200)
    end
  end
end
