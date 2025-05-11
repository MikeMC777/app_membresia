require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :title => "Title",
      :description => "MyText",
      :event_type => 2,
      :location => "Location",
      :image_url => "Image Url",
      :video_url => "Video Url",
      :order => 3,
      :banner => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Image Url/)
    expect(rendered).to match(/Video Url/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
  end
end
