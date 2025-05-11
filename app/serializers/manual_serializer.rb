class ManualSerializer < ActiveModel::Serializer
  attributes :id, :type, :url, :name, :deleted_at
  has_one :team
end
