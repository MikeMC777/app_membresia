FactoryBot.define do
  factory :meeting do
    team { nil }
    title { "MyString" }
    date { "2025-04-27 01:42:18" }
    mode { 1 }
    url { "MyString" }
    location { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
    deleted_at { "2025-04-27 01:42:18" }
  end
end
