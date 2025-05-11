class AttendanceSerializer < ActiveModel::Serializer
  attributes :id, :attendance_type, :deleted_at
  has_one :member
  has_one :event
end
