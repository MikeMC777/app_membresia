require 'rails_helper'

RSpec.describe "file_uploads/edit", type: :view do
  before(:each) do
    @file_upload = assign(:file_upload, FileUpload.create!(
      :name => "MyString",
      :size => 1,
      :url => "MyString",
      :folder => nil
    ))
  end

  it "renders the edit file_upload form" do
    render

    assert_select "form[action=?][method=?]", file_upload_path(@file_upload), "post" do

      assert_select "input[name=?]", "file_upload[name]"

      assert_select "input[name=?]", "file_upload[size]"

      assert_select "input[name=?]", "file_upload[url]"

      assert_select "input[name=?]", "file_upload[folder_id]"
    end
  end
end
