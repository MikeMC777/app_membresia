require "rails_helper"

RSpec.describe "Api::V1::Members#create", type: :request do
  include_context "members api setup"
  let(:valid_attributes)   { attributes_for(:member) }
  let(:invalid_attributes) { { first_name: "", email: "" } }

  context "as admin" do
    context "with valid params" do
      it "creates member with default sympathizer status" do
        expect {
          post api_v1_members_path, params: { member: valid_attributes },
               headers: auth_headers_for(admin_user), as: :json
        }.to change(Member, :count).by(1)
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["status"]).to eq("sympathizer")
      end

      it "rejects creation if status explicitly not sympathizer" do
        post api_v1_members_path, params: { member: valid_attributes.merge(status: "active") },
             headers: auth_headers_for(admin_user), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include(a_string_matching(/must start as sympathizer/i))
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        post api_v1_members_path, params: { member: invalid_attributes },
             headers: auth_headers_for(admin_user), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "as secretary" do
    it "can create" do
      post api_v1_members_path, params: { member: valid_attributes },
           headers: auth_headers_for(secretary_user), as: :json
      expect(response).to have_http_status(:created)
    end
  end

  context "as unauthorized user" do
    it "is forbidden" do
      post api_v1_members_path, params: { member: valid_attributes },
           headers: auth_headers_for(programmer_user), as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end
end
