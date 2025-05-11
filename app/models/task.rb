class Task < ApplicationRecord
  belongs_to :assigned_to
  belongs_to :monthly_schedule
  belongs_to :created_by
end
