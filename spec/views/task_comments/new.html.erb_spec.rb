require 'rails_helper'

RSpec.describe "task_comments/new", type: :view do
  before(:each) do
    assign(:task_comment, TaskComment.new(
      :body => "MyText",
      :task => nil,
      :member => nil
    ))
  end

  it "renders new task_comment form" do
    render

    assert_select "form[action=?][method=?]", task_comments_path, "post" do

      assert_select "textarea[name=?]", "task_comment[body]"

      assert_select "input[name=?]", "task_comment[task_id]"

      assert_select "input[name=?]", "task_comment[member_id]"
    end
  end
end
