require "rails_helper"

RSpec.describe MonthlySchedulesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/monthly_schedules").to route_to("monthly_schedules#index")
    end

    it "routes to #new" do
      expect(:get => "/monthly_schedules/new").to route_to("monthly_schedules#new")
    end

    it "routes to #show" do
      expect(:get => "/monthly_schedules/1").to route_to("monthly_schedules#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/monthly_schedules/1/edit").to route_to("monthly_schedules#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/monthly_schedules").to route_to("monthly_schedules#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/monthly_schedules/1").to route_to("monthly_schedules#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/monthly_schedules/1").to route_to("monthly_schedules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/monthly_schedules/1").to route_to("monthly_schedules#destroy", :id => "1")
    end
  end
end
