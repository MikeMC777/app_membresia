require 'rails_helper'

RSpec.describe "meetings/index", type: :view do
  before(:each) do
    assign(:meetings, [
      Meeting.create!(
        :team => nil,
        :title => "Title",
        :mode => 2,
        :url => "Url",
        :location => "Location",
        :latitude => 3.5,
        :longitude => 4.5
      ),
      Meeting.create!(
        :team => nil,
        :title => "Title",
        :mode => 2,
        :url => "Url",
        :location => "Location",
        :latitude => 3.5,
        :longitude => 4.5
      )
    ])
  end

  it "renders a list of meetings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
  end
end
