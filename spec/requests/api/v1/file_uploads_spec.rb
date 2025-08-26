require 'rails_helper'

RSpec.describe "Api::V1::FileUploads", type: :request do
  describe "GET /file_uploads" do
    it "works! (now write some real specs)" do
      get file_uploads_path
      expect(response).to have_http_status(200)
    end
  end
end
