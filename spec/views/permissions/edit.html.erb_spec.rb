require 'rails_helper'

RSpec.describe "permissions/edit", type: :view do
  before(:each) do
    @permission = assign(:permission, Permission.create!(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit permission form" do
    render

    assert_select "form[action=?][method=?]", permission_path(@permission), "post" do

      assert_select "input[name=?]", "permission[name]"

      assert_select "textarea[name=?]", "permission[description]"
    end
  end
end
