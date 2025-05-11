require 'rails_helper'

RSpec.describe "permissions/new", type: :view do
  before(:each) do
    assign(:permission, Permission.new(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new permission form" do
    render

    assert_select "form[action=?][method=?]", permissions_path, "post" do

      assert_select "input[name=?]", "permission[name]"

      assert_select "textarea[name=?]", "permission[description]"
    end
  end
end
