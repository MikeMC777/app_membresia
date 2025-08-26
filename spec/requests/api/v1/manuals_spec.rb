require 'rails_helper'

RSpec.describe "Api::V1::Manuals", type: :request do
  describe "GET /manuals" do
    it "works! (now write some real specs)" do
      get manuals_path
      expect(response).to have_http_status(200)
    end
  end
end
