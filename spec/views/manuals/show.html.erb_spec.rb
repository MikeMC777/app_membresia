require 'rails_helper'

RSpec.describe "manuals/show", type: :view do
  before(:each) do
    @manual = assign(:manual, Manual.create!(
      :team => nil,
      :type => 2,
      :url => "Url",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Name/)
  end
end
