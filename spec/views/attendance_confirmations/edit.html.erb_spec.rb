require 'rails_helper'

RSpec.describe "attendance_confirmations/edit", type: :view do
  before(:each) do
    @attendance_confirmation = assign(:attendance_confirmation, AttendanceConfirmation.create!(
      :member => nil,
      :meeting => nil,
      :confirmed => false,
      :attendance_type => 1
    ))
  end

  it "renders the edit attendance_confirmation form" do
    render

    assert_select "form[action=?][method=?]", attendance_confirmation_path(@attendance_confirmation), "post" do

      assert_select "input[name=?]", "attendance_confirmation[member_id]"

      assert_select "input[name=?]", "attendance_confirmation[meeting_id]"

      assert_select "input[name=?]", "attendance_confirmation[confirmed]"

      assert_select "input[name=?]", "attendance_confirmation[attendance_type]"
    end
  end
end
