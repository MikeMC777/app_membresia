require "rails_helper"

RSpec.describe ManualsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/manuals").to route_to("manuals#index")
    end

    it "routes to #new" do
      expect(:get => "/manuals/new").to route_to("manuals#new")
    end

    it "routes to #show" do
      expect(:get => "/manuals/1").to route_to("manuals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/manuals/1/edit").to route_to("manuals#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/manuals").to route_to("manuals#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/manuals/1").to route_to("manuals#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/manuals/1").to route_to("manuals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/manuals/1").to route_to("manuals#destroy", :id => "1")
    end
  end
end
