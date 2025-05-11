require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :title => "MyString",
      :description => "MyText",
      :event_type => 1,
      :location => "MyString",
      :image_url => "MyString",
      :video_url => "MyString",
      :order => 1,
      :banner => false
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[title]"

      assert_select "textarea[name=?]", "event[description]"

      assert_select "input[name=?]", "event[event_type]"

      assert_select "input[name=?]", "event[location]"

      assert_select "input[name=?]", "event[image_url]"

      assert_select "input[name=?]", "event[video_url]"

      assert_select "input[name=?]", "event[order]"

      assert_select "input[name=?]", "event[banner]"
    end
  end
end
