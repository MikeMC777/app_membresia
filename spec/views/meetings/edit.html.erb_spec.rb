require 'rails_helper'

RSpec.describe "meetings/edit", type: :view do
  before(:each) do
    @meeting = assign(:meeting, Meeting.create!(
      :team => nil,
      :title => "MyString",
      :mode => 1,
      :url => "MyString",
      :location => "MyString",
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders the edit meeting form" do
    render

    assert_select "form[action=?][method=?]", meeting_path(@meeting), "post" do

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
