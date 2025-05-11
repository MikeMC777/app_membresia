require 'rails_helper'

RSpec.describe "manuals/edit", type: :view do
  before(:each) do
    @manual = assign(:manual, Manual.create!(
      :team => nil,
      :type => 1,
      :url => "MyString",
      :name => "MyString"
    ))
  end

  it "renders the edit manual form" do
    render

    assert_select "form[action=?][method=?]", manual_path(@manual), "post" do

      assert_select "input[name=?]", "manual[team_id]"

      assert_select "input[name=?]", "manual[type]"

      assert_select "input[name=?]", "manual[url]"

      assert_select "input[name=?]", "manual[name]"
    end
  end
end
