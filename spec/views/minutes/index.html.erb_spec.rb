require 'rails_helper'

RSpec.describe "minutes/index", type: :view do
  before(:each) do
    assign(:minutes, [
      Minute.create!(
        :meeting => nil,
        :title => "Title",
        :agenda => "MyText",
        :development => "MyText"
      ),
      Minute.create!(
        :meeting => nil,
        :title => "Title",
        :agenda => "MyText",
        :development => "MyText"
      )
    ])
  end

  it "renders a list of minutes" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
