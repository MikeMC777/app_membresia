require 'rails_helper'

RSpec.describe "task_comments/edit", type: :view do
  before(:each) do
    @task_comment = assign(:task_comment, TaskComment.create!(
      :body => "MyText",
      :task => nil,
      :member => nil
    ))
  end

  it "renders the edit task_comment form" do
    render

    assert_select "form[action=?][method=?]", task_comment_path(@task_comment), "post" do

      assert_select "textarea[name=?]", "task_comment[body]"

      assert_select "input[name=?]", "task_comment[task_id]"

      assert_select "input[name=?]", "task_comment[member_id]"
    end
  end
end
