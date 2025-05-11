FactoryBot.define do
  factory :event do
    title { "MyString" }
    description { "MyText" }
    event_type { 1 }
    location { "MyString" }
    image_url { "MyString" }
    video_url { "MyString" }
    start_date { "2025-04-27 01:15:03" }
    due_date { "2025-04-27 01:15:03" }
    publication_date { "2025-04-27 01:15:03" }
    order { 1 }
    banner { false }
    deleted_at { "2025-04-27 01:15:03" }
  end
end
