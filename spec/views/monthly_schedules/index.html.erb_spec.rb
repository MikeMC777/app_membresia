require 'rails_helper'

RSpec.describe "monthly_schedules/index", type: :view do
  before(:each) do
    assign(:monthly_schedules, [
      MonthlySchedule.create!(
        :title => "Title",
        :description => "MyText",
        :created_by => nil,
        :scheduled_month => "Scheduled Month",
        :status => "Status"
      ),
      MonthlySchedule.create!(
        :title => "Title",
        :description => "MyText",
        :created_by => nil,
        :scheduled_month => "Scheduled Month",
        :status => "Status"
      )
    ])
  end

  it "renders a list of monthly_schedules" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Scheduled Month".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
