require 'rails_helper'

RSpec.describe "minutes/edit", type: :view do
  before(:each) do
    @minute = assign(:minute, Minute.create!(
      :meeting => nil,
      :title => "MyString",
      :agenda => "MyText",
      :development => "MyText"
    ))
  end

  it "renders the edit minute form" do
    render

    assert_select "form[action=?][method=?]", minute_path(@minute), "post" do

      assert_select "input[name=?]", "minute[meeting_id]"

      assert_select "input[name=?]", "minute[title]"

      assert_select "textarea[name=?]", "minute[agenda]"

      assert_select "textarea[name=?]", "minute[development]"
    end
  end
end
