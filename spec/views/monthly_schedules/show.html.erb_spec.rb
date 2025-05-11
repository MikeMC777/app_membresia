require 'rails_helper'

RSpec.describe "monthly_schedules/show", type: :view do
  before(:each) do
    @monthly_schedule = assign(:monthly_schedule, MonthlySchedule.create!(
      :title => "Title",
      :description => "MyText",
      :created_by => nil,
      :scheduled_month => "Scheduled Month",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Scheduled Month/)
    expect(rendered).to match(/Status/)
  end
end
