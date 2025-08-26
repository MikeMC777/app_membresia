require 'rails_helper'

RSpec.describe "Api::V1::TaskComments", type: :request do
  describe "GET /task_comments" do
    it "works! (now write some real specs)" do
      get task_comments_path
      expect(response).to have_http_status(200)
    end
  end
end
