require 'rails_helper'

RSpec.describe "meetings/show", type: :view do
  before(:each) do
    @meeting = assign(:meeting, Meeting.create!(
      :team => nil,
      :title => "Title",
      :mode => 2,
      :url => "Url",
      :location => "Location",
      :latitude => 3.5,
      :longitude => 4.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
  end
end
