FactoryBot.define do
  factory :minute do
    meeting { nil }
    title { "MyString" }
    agenda { "MyText" }
    development { "MyText" }
    ending_time { "2025-04-27 02:58:07" }
    deleted_at { "2025-04-27 02:58:07" }
  end
end
