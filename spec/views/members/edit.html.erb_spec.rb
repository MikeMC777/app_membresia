require 'rails_helper'

RSpec.describe "members/edit", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      :first_name => "MyString",
      :second_name => "MyString",
      :first_surname => "MyString",
      :second_surname => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :status => 1,
      :marital_status => 1,
      :gender => 1,
      :address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :country => "MyString"
    ))
  end

  it "renders the edit member form" do
    render

    assert_select "form[action=?][method=?]", member_path(@member), "post" do

      assert_select "input[name=?]", "member[first_name]"

      assert_select "input[name=?]", "member[second_name]"

      assert_select "input[name=?]", "member[first_surname]"

      assert_select "input[name=?]", "member[second_surname]"

      assert_select "input[name=?]", "member[email]"

      assert_select "input[name=?]", "member[phone]"

      assert_select "input[name=?]", "member[status]"

      assert_select "input[name=?]", "member[marital_status]"

      assert_select "input[name=?]", "member[gender]"

      assert_select "input[name=?]", "member[address]"

      assert_select "input[name=?]", "member[city]"

      assert_select "input[name=?]", "member[state]"

      assert_select "input[name=?]", "member[country]"
    end
  end
end
