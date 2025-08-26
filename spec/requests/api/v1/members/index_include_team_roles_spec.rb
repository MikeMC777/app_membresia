require "rails_helper"

RSpec.describe "Api::V1::Members#index include_team_roles", type: :request do
  include_context "members api setup"

  it "includes team_roles when include_team_roles=true" do
    team           = create(:team, name: "Equipo X")
    encargado_role = create(:role, name: "encargado")
    member         = create(:member)
    create(:team_role, member: member, team: team, role: encargado_role)

    get api_v1_members_path,
        params: { include_team_roles: true },
        headers: auth_headers_for(admin_user)

    expect(response).to have_http_status(:ok)
    json  = JSON.parse(response.body)
    found = json.find { |m| m["id"] == member.id }
    expect(found).to be_present
    expect(found["team_roles"]).to be_an(Array)
    expect(found["team_roles"].first["team_name"]).to eq("Equipo X")
    expect(found["team_roles"].first["role_name"]).to eq("encargado")
  end
end
