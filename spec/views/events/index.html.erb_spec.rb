require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :title => "Title",
        :description => "MyText",
        :event_type => 2,
        :location => "Location",
        :image_url => "Image Url",
        :video_url => "Video Url",
        :order => 3,
        :banner => false
      ),
      Event.create!(
        :title => "Title",
        :description => "MyText",
        :event_type => 2,
        :location => "Location",
        :image_url => "Image Url",
        :video_url => "Video Url",
        :order => 3,
        :banner => false
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => "Video Url".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
