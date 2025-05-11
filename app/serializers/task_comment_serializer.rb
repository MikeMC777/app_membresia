class TaskCommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :deleted_at
  has_one :task
  has_one :member
end
