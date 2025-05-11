require 'rails_helper'

RSpec.describe "folders/index", type: :view do
  before(:each) do
    assign(:folders, [
      Folder.create!(
        :name => "Name",
        :size => 2,
        :team => nil,
        :parent_folder => nil
      ),
      Folder.create!(
        :name => "Name",
        :size => 2,
        :team => nil,
        :parent_folder => nil
      )
    ])
  end

  it "renders a list of folders" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
