class TeamRoleSerializer < ActiveModel::Serializer
  attributes :team_name, :role_name

  def team_name
    object.team.name
  end

  def role_name
    object.role.name
  end
end
