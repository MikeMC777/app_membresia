class MeetingSerializer < ActiveModel::Serializer
  attributes :id, :title, :date, :mode, :url, :location, :latitude, :longitude, :deleted_at
  has_one :team
end
