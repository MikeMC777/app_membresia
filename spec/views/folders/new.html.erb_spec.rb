require 'rails_helper'

RSpec.describe "folders/new", type: :view do
  before(:each) do
    assign(:folder, Folder.new(
      :name => "MyString",
      :size => 1,
      :team => nil,
      :parent_folder => nil
    ))
  end

  it "renders new folder form" do
    render

    assert_select "form[action=?][method=?]", folders_path, "post" do

      assert_select "input[name=?]", "folder[name]"

      assert_select "input[name=?]", "folder[size]"

      assert_select "input[name=?]", "folder[team_id]"

      assert_select "input[name=?]", "folder[parent_folder_id]"
    end
  end
end
