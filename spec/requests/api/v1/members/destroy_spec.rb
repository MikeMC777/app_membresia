require "rails_helper"

RSpec.describe "Api::V1::Members#destroy", type: :request do
  include_context "members api setup"
  let!(:another_member) { create(:member, status: :sympathizer) }

  context "as admin" do
    it "soft deletes the member" do
      delete api_v1_member_path(another_member),
             headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:no_content)
      expect(Member.with_deleted.find(another_member.id)).to be_deleted
    end
  end

  context "as secretary" do
    it "is forbidden" do
      delete api_v1_member_path(another_member),
             headers: auth_headers_for(secretary_user)
      expect(response).to have_http_status(:forbidden)
    end
  end
end
