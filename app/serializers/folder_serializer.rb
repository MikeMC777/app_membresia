class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :size, :deleted_at
  has_one :team
  has_one :parent_folder
end
