FactoryBot.define do
  factory :attendance_confirmation do
    member { nil }
    meeting { nil }
    confirmed { false }
    attendance_type { 1 }
    deleted_at { "2025-04-27 01:44:01" }
  end
end
