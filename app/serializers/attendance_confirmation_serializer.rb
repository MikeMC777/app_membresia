class AttendanceConfirmationSerializer < ActiveModel::Serializer
  attributes :id, :confirmed, :attendance_type, :deleted_at
  has_one :member
  has_one :meeting
end
