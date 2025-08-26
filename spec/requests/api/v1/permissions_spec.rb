require 'rails_helper'

RSpec.describe "Api::V1::Permissions", type: :request do
  describe "GET /permissions" do
    it "works! (now write some real specs)" do
      get permissions_path
      expect(response).to have_http_status(200)
    end
  end
end
