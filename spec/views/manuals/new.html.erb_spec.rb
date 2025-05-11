require 'rails_helper'

RSpec.describe "manuals/new", type: :view do
  before(:each) do
    assign(:manual, Manual.new(
      :team => nil,
      :type => 1,
      :url => "MyString",
      :name => "MyString"
    ))
  end

  it "renders new manual form" do
    render

    assert_select "form[action=?][method=?]", manuals_path, "post" do

      assert_select "input[name=?]", "manual[team_id]"

      assert_select "input[name=?]", "manual[type]"

      assert_select "input[name=?]", "manual[url]"

      assert_select "input[name=?]", "manual[name]"
    end
  end
end
