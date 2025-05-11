FactoryBot.define do
  factory :member do
    first_name { "MyString" }
    second_name { "MyString" }
    first_surname { "MyString" }
    second_surname { "MyString" }
    email { "MyString" }
    phone { "MyString" }
    status { 1 }
    birth_date { "2025-04-27" }
    baptism_date { "2025-04-27" }
    marital_status { 1 }
    gender { 1 }
    wedding_date { "2025-04-27" }
    membership_date { "2025-04-27" }
    address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    country { "MyString" }
    deleted_at { "2025-04-27 01:12:25" }
  end
end
