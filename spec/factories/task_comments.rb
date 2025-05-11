FactoryBot.define do
  factory :task_comment do
    body { "MyText" }
    task { nil }
    member { nil }
    deleted_at { "2025-04-27 01:37:47" }
  end
end
