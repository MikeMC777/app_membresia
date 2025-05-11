require 'rails_helper'

RSpec.describe "file_uploads/show", type: :view do
  before(:each) do
    @file_upload = assign(:file_upload, FileUpload.create!(
      :name => "Name",
      :size => 2,
      :url => "Url",
      :folder => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(//)
  end
end
