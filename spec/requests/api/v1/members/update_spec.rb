require "rails_helper"

RSpec.describe "Api::V1::Members#update", type: :request do
  include_context "members api setup"
  let!(:another_member) { create(:member, status: :sympathizer) }

  context "as admin" do
    it "updates the member" do
      patch api_v1_member_path(another_member),
            params: { member: { first_name: "Changed" } },
            headers: auth_headers_for(admin_user), as: :json
      expect(response).to have_http_status(:ok)
      expect(another_member.reload.first_name).to eq("Changed")
    end
  end

  context "as secretary" do
    it "can update" do
      patch api_v1_member_path(another_member),
            params: { member: { first_name: "Secret" } },
            headers: auth_headers_for(secretary_user), as: :json
      expect(response).to have_http_status(:ok)
      expect(another_member.reload.first_name).to eq("Secret")
    end
  end

  context "as unauthorized user" do
    it "is forbidden" do
      patch api_v1_member_path(another_member),
            params: { member: { first_name: "X" } },
            headers: auth_headers_for(programmer_user), as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end
end
