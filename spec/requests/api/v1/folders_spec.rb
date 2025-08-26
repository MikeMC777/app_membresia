require 'rails_helper'

RSpec.describe "Api::V1::Folders", type: :request do
  describe "GET /folders" do
    it "works! (now write some real specs)" do
      get folders_path
      expect(response).to have_http_status(200)
    end
  end
end
