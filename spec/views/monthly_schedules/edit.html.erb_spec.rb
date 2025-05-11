require 'rails_helper'

RSpec.describe "monthly_schedules/edit", type: :view do
  before(:each) do
    @monthly_schedule = assign(:monthly_schedule, MonthlySchedule.create!(
      :title => "MyString",
      :description => "MyText",
      :created_by => nil,
      :scheduled_month => "MyString",
      :status => "MyString"
    ))
  end

  it "renders the edit monthly_schedule form" do
    render

    assert_select "form[action=?][method=?]", monthly_schedule_path(@monthly_schedule), "post" do

      assert_select "input[name=?]", "monthly_schedule[title]"

      assert_select "textarea[name=?]", "monthly_schedule[description]"

      assert_select "input[name=?]", "monthly_schedule[created_by_id]"

      assert_select "input[name=?]", "monthly_schedule[scheduled_month]"

      assert_select "input[name=?]", "monthly_schedule[status]"
    end
  end
end
