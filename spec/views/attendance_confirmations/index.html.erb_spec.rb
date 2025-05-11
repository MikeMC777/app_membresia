require 'rails_helper'

RSpec.describe "attendance_confirmations/index", type: :view do
  before(:each) do
    assign(:attendance_confirmations, [
      AttendanceConfirmation.create!(
        :member => nil,
        :meeting => nil,
        :confirmed => false,
        :attendance_type => 2
      ),
      AttendanceConfirmation.create!(
        :member => nil,
        :meeting => nil,
        :confirmed => false,
        :attendance_type => 2
      )
    ])
  end

  it "renders a list of attendance_confirmations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
