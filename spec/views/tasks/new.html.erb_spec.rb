require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :title => "MyString",
      :description => "MyText",
      :assigned_to => nil,
      :monthly_schedule => nil,
      :status => "MyString",
      :created_by => nil
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input[name=?]", "task[title]"

      assert_select "textarea[name=?]", "task[description]"

      assert_select "input[name=?]", "task[assigned_to_id]"

      assert_select "input[name=?]", "task[monthly_schedule_id]"

      assert_select "input[name=?]", "task[status]"

      assert_select "input[name=?]", "task[created_by_id]"
    end
  end
end
