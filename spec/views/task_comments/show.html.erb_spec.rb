require 'rails_helper'

RSpec.describe "task_comments/show", type: :view do
  before(:each) do
    @task_comment = assign(:task_comment, TaskComment.create!(
      :body => "MyText",
      :task => nil,
      :member => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
