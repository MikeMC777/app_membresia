class MonthlyScheduleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :scheduled_month, :status, :due_date, :deleted_at
  has_one :created_by
end
