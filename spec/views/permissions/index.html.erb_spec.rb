require 'rails_helper'

RSpec.describe "permissions/index", type: :view do
  before(:each) do
    assign(:permissions, [
      Permission.create!(
        :name => "Name",
        :description => "MyText"
      ),
      Permission.create!(
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of permissions" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
