require 'rails_helper'

RSpec.describe "file_uploads/new", type: :view do
  before(:each) do
    assign(:file_upload, FileUpload.new(
      :name => "MyString",
      :size => 1,
      :url => "MyString",
      :folder => nil
    ))
  end

  it "renders new file_upload form" do
    render

    assert_select "form[action=?][method=?]", file_uploads_path, "post" do

      assert_select "input[name=?]", "file_upload[name]"

      assert_select "input[name=?]", "file_upload[size]"

      assert_select "input[name=?]", "file_upload[url]"

      assert_select "input[name=?]", "file_upload[folder_id]"
    end
  end
end
