require 'rails_helper'

RSpec.describe "roles/new", type: :view do
  before(:each) do
    assign(:role, Role.new(
      :name => "MyString",
      :scope => 1,
      :description => "MyText"
    ))
  end

  it "renders new role form" do
    render

    assert_select "form[action=?][method=?]", roles_path, "post" do

      assert_select "input[name=?]", "role[name]"

      assert_select "input[name=?]", "role[scope]"

      assert_select "textarea[name=?]", "role[description]"
    end
  end
end
