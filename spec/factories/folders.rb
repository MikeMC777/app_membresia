FactoryBot.define do
  factory :folder do
    name { "MyString" }
    size { 1 }
    team { nil }
    parent_folder { nil }
    deleted_at { "2025-04-27 01:50:56" }
  end
end
