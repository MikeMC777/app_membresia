require 'rails_helper'

RSpec.describe "members/show", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      :first_name => "First Name",
      :second_name => "Second Name",
      :first_surname => "First Surname",
      :second_surname => "Second Surname",
      :email => "Email",
      :phone => "Phone",
      :status => 2,
      :marital_status => 3,
      :gender => 4,
      :address => "Address",
      :city => "City",
      :state => "State",
      :country => "Country"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Second Name/)
    expect(rendered).to match(/First Surname/)
    expect(rendered).to match(/Second Surname/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Country/)
  end
end
