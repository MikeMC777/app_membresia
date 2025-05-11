require 'rails_helper'

RSpec.describe "meetings/new", type: :view do
  before(:each) do
    assign(:meeting, Meeting.new(
      :team => nil,
      :title => "MyString",
      :mode => 1,
      :url => "MyString",
      :location => "MyString",
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders new meeting form" do
    render

    assert_select "form[action=?][method=?]", meetings_path, "post" do

      assert_select "input[name=?]", "meeting[team_id]"

      assert_select "input[name=?]", "meeting[title]"

      assert_select "input[name=?]", "meeting[mode]"

      assert_select "input[name=?]", "meeting[url]"

      assert_select "input[name=?]", "meeting[location]"

      assert_select "input[name=?]", "meeting[latitude]"

      assert_select "input[name=?]", "meeting[longitude]"
    end
  end
end
