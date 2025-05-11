require 'rails_helper'

RSpec.describe "AttendanceConfirmations", type: :request do
  describe "GET /attendance_confirmations" do
    it "works! (now write some real specs)" do
      get attendance_confirmations_path
      expect(response).to have_http_status(200)
    end
  end
end
