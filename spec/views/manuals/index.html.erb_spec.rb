require 'rails_helper'

RSpec.describe "manuals/index", type: :view do
  before(:each) do
    assign(:manuals, [
      Manual.create!(
        :team => nil,
        :type => 2,
        :url => "Url",
        :name => "Name"
      ),
      Manual.create!(
        :team => nil,
        :type => 2,
        :url => "Url",
        :name => "Name"
      )
    ])
  end

  it "renders a list of manuals" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
