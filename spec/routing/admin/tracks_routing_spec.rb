require "spec_helper"

describe Admin::TracksController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/tracks").should route_to("admin/tracks#index")
    end

    it "routes to #new" do
      get("/admin/tracks/new").should route_to("admin/tracks#new")
    end

    it "routes to #show" do
      get("/admin/tracks/1").should route_to("admin/tracks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/tracks/1/edit").should route_to("admin/tracks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/tracks").should route_to("admin/tracks#create")
    end

    it "routes to #update" do
      put("/admin/tracks/1").should route_to("admin/tracks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/tracks/1").should route_to("admin/tracks#destroy", :id => "1")
    end

  end
end
