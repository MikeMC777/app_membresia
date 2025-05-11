require 'rails_helper'

RSpec.describe "attendance_confirmations/show", type: :view do
  before(:each) do
    @attendance_confirmation = assign(:attendance_confirmation, AttendanceConfirmation.create!(
      :member => nil,
      :meeting => nil,
      :confirmed => false,
      :attendance_type => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
  end
end
