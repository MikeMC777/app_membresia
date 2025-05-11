FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    assigned_to { nil }
    monthly_schedule { nil }
    start_date { "2025-04-27" }
    due_date { "2025-04-27" }
    status { "MyString" }
    created_by { nil }
    deleted_at { "2025-04-27 02:18:18" }
  end
end
