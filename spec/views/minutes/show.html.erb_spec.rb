require 'rails_helper'

RSpec.describe "minutes/show", type: :view do
  before(:each) do
    @minute = assign(:minute, Minute.create!(
      :meeting => nil,
      :title => "Title",
      :agenda => "MyText",
      :development => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
