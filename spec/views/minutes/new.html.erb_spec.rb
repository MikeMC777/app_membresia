require 'rails_helper'

RSpec.describe "minutes/new", type: :view do
  before(:each) do
    assign(:minute, Minute.new(
      :meeting => nil,
      :title => "MyString",
      :agenda => "MyText",
      :development => "MyText"
    ))
  end

  it "renders new minute form" do
    render

    assert_select "form[action=?][method=?]", minutes_path, "post" do

      assert_select "input[name=?]", "minute[meeting_id]"

      assert_select "input[name=?]", "minute[title]"

      assert_select "textarea[name=?]", "minute[agenda]"

      assert_select "textarea[name=?]", "minute[development]"
    end
  end
end
