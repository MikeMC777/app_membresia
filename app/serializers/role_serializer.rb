class RoleSerializer < ActiveModel::Serializer
  attributes :id, :name, :scope, :description, :deleted_at
end
