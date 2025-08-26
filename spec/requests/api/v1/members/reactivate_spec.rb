require "rails_helper"

RSpec.describe "Api::V1::Members#reactivate", type: :request do
  include_context "members api setup"
  let!(:another_member) { create(:member, status: :sympathizer) }

  context "as admin" do
    it "reactivates an inactive member" do
      another_member.update!(status: :inactive)
      patch reactivate_api_v1_member_path(another_member),
            headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      expect(another_member.reload.status).to eq("active")
    end

    it "restores a soft-deleted member" do
      another_member.destroy
      patch reactivate_api_v1_member_path(another_member),
            headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      expect(another_member.reload.deleted?).to be false
    end

    it "returns error if already active" do
      patch reactivate_api_v1_member_path(another_member),
            headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "as secretary" do
    it "can reactivate inactive" do
      another_member.update!(status: :inactive)
      patch reactivate_api_v1_member_path(another_member),
            headers: auth_headers_for(secretary_user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "as unauthorized user" do
    it "is forbidden" do
      patch reactivate_api_v1_member_path(another_member),
            headers: auth_headers_for(programmer_user)
      expect(response).to have_http_status(:forbidden)
    end
  end
end
