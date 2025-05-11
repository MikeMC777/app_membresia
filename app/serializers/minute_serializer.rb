class MinuteSerializer < ActiveModel::Serializer
  attributes :id, :title, :agenda, :development, :ending_time, :deleted_at
  has_one :meeting
end
