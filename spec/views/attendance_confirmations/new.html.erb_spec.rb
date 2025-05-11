require 'rails_helper'

RSpec.describe "attendance_confirmations/new", type: :view do
  before(:each) do
    assign(:attendance_confirmation, AttendanceConfirmation.new(
      :member => nil,
      :meeting => nil,
      :confirmed => false,
      :attendance_type => 1
    ))
  end

  it "renders new attendance_confirmation form" do
    render

    assert_select "form[action=?][method=?]", attendance_confirmations_path, "post" do

      assert_select "input[name=?]", "attendance_confirmation[member_id]"

      assert_select "input[name=?]", "attendance_confirmation[meeting_id]"

      assert_select "input[name=?]", "attendance_confirmation[confirmed]"

      assert_select "input[name=?]", "attendance_confirmation[attendance_type]"
    end
  end
end
