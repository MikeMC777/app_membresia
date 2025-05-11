require 'rails_helper'

RSpec.describe "file_uploads/index", type: :view do
  before(:each) do
    assign(:file_uploads, [
      FileUpload.create!(
        :name => "Name",
        :size => 2,
        :url => "Url",
        :folder => nil
      ),
      FileUpload.create!(
        :name => "Name",
        :size => 2,
        :url => "Url",
        :folder => nil
      )
    ])
  end

  it "renders a list of file_uploads" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
