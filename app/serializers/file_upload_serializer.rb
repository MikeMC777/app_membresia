class FileUploadSerializer < ActiveModel::Serializer
  attributes :id, :name, :size, :url, :deleted_at
  has_one :folder
end
