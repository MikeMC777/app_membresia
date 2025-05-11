class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :due_date, :status, :deleted_at
  has_one :assigned_to
  has_one :monthly_schedule
  has_one :created_by
end
