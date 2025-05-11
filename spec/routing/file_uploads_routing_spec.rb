require "rails_helper"

RSpec.describe FileUploadsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/file_uploads").to route_to("file_uploads#index")
    end

    it "routes to #new" do
      expect(:get => "/file_uploads/new").to route_to("file_uploads#new")
    end

    it "routes to #show" do
      expect(:get => "/file_uploads/1").to route_to("file_uploads#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/file_uploads/1/edit").to route_to("file_uploads#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/file_uploads").to route_to("file_uploads#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/file_uploads/1").to route_to("file_uploads#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/file_uploads/1").to route_to("file_uploads#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/file_uploads/1").to route_to("file_uploads#destroy", :id => "1")
    end
  end
end
