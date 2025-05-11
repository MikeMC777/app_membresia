require 'rails_helper'

RSpec.describe "folders/edit", type: :view do
  before(:each) do
    @folder = assign(:folder, Folder.create!(
      :name => "MyString",
      :size => 1,
      :team => nil,
      :parent_folder => nil
    ))
  end

  it "renders the edit folder form" do
    render

    assert_select "form[action=?][method=?]", folder_path(@folder), "post" do

      assert_select "input[name=?]", "folder[name]"

      assert_select "input[name=?]", "folder[size]"

      assert_select "input[name=?]", "folder[team_id]"

      assert_select "input[name=?]", "folder[parent_folder_id]"
    end
  end
end
