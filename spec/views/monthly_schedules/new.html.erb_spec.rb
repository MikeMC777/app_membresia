require 'rails_helper'

RSpec.describe "monthly_schedules/new", type: :view do
  before(:each) do
    assign(:monthly_schedule, MonthlySchedule.new(
      :title => "MyString",
      :description => "MyText",
      :created_by => nil,
      :scheduled_month => "MyString",
      :status => "MyString"
    ))
  end

  it "renders new monthly_schedule form" do
    render

    assert_select "form[action=?][method=?]", monthly_schedules_path, "post" do

      assert_select "input[name=?]", "monthly_schedule[title]"

      assert_select "textarea[name=?]", "monthly_schedule[description]"

      assert_select "input[name=?]", "monthly_schedule[created_by_id]"

      assert_select "input[name=?]", "monthly_schedule[scheduled_month]"

      assert_select "input[name=?]", "monthly_schedule[status]"
    end
  end
end
