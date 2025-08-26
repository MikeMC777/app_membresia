require "rails_helper"

RSpec.describe "Api::V1::Members#show", type: :request do
  include_context "members api setup"

  let!(:own_member)     { create(:member, status: :sympathizer) }
  let!(:member_user)    { create(:user, member: own_member) }
  let!(:another_member) { create(:member, status: :sympathizer) }

  context "as admin" do
    it "shows any member" do
      get api_v1_member_path(another_member), headers: auth_headers_for(admin_user)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(another_member.id)
    end
  end

  context "as secretary" do
    it "shows any member" do
      get api_v1_member_path(another_member), headers: auth_headers_for(secretary_user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "as programmer" do
    it "is forbidden" do
      get api_v1_member_path(another_member), headers: auth_headers_for(programmer_user)
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "as member" do
    it "can view own record" do
      get api_v1_member_path(own_member), headers: auth_headers_for(member_user)
      expect(response).to have_http_status(:ok)
    end

    it "cannot view another member" do
      get api_v1_member_path(another_member), headers: auth_headers_for(member_user)
      expect(response).to have_http_status(:forbidden)
    end
  end
end
