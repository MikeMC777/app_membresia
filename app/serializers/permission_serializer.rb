class PermissionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :deleted_at
end
