class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :event_type, :location, :image_url, :video_url, :start_date, :due_date, :publication_date, :order, :banner, :deleted_at
end
