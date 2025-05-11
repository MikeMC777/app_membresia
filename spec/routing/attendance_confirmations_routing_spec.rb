require "rails_helper"

RSpec.describe AttendanceConfirmationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/attendance_confirmations").to route_to("attendance_confirmations#index")
    end

    it "routes to #new" do
      expect(:get => "/attendance_confirmations/new").to route_to("attendance_confirmations#new")
    end

    it "routes to #show" do
      expect(:get => "/attendance_confirmations/1").to route_to("attendance_confirmations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/attendance_confirmations/1/edit").to route_to("attendance_confirmations#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/attendance_confirmations").to route_to("attendance_confirmations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/attendance_confirmations/1").to route_to("attendance_confirmations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/attendance_confirmations/1").to route_to("attendance_confirmations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/attendance_confirmations/1").to route_to("attendance_confirmations#destroy", :id => "1")
    end
  end
end
