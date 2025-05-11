FactoryBot.define do
  factory :monthly_schedule do
    title { "MyString" }
    description { "MyText" }
    created_by { nil }
    scheduled_month { "MyString" }
    status { "MyString" }
    due_date { "2025-04-27" }
    deleted_at { "2025-04-27 02:10:45" }
  end
end
