require 'rails_helper'

RSpec.describe "members/index", type: :view do
  before(:each) do
    assign(:members, [
      Member.create!(
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
      ),
      Member.create!(
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
      )
    ])
  end

  it "renders a list of members" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Second Name".to_s, :count => 2
    assert_select "tr>td", :text => "First Surname".to_s, :count => 2
    assert_select "tr>td", :text => "Second Surname".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
  end
end
