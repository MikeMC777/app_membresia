class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo_url, :description, :deleted_at
end
