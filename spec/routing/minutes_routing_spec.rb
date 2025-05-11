require "rails_helper"

RSpec.describe MinutesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/minutes").to route_to("minutes#index")
    end

    it "routes to #new" do
      expect(:get => "/minutes/new").to route_to("minutes#new")
    end

    it "routes to #show" do
      expect(:get => "/minutes/1").to route_to("minutes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/minutes/1/edit").to route_to("minutes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/minutes").to route_to("minutes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/minutes/1").to route_to("minutes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/minutes/1").to route_to("minutes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/minutes/1").to route_to("minutes#destroy", :id => "1")
    end
  end
end
