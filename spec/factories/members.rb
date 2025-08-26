FactoryBot.define do
  factory :member do
    first_name      { Faker::Name.first_name }
    second_name     { Faker::Name.first_name }
    first_surname   { Faker::Name.last_name }
    second_surname  { Faker::Name.last_name }
    email           { Faker::Internet.unique.email }
    phone           { Faker::PhoneNumber.cell_phone }
    status          { :sympathizer }  # ahora el default cumple la validación de creación
    birth_date      { Faker::Date.birthday(min_age: 18, max_age: 65) }
    baptism_date    { Faker::Date.backward(days: 2000) }
    marital_status  { Member.marital_statuses.keys.sample }
    gender          { Member.genders.keys.sample }
    membership_date { Faker::Date.backward(days: 1000) }
    address         { Faker::Address.street_address }
    city            { Faker::Address.city }
    state           { Faker::Address.state }
    country         { Faker::Address.country }

    # wedding_date se ajusta después según marital_status
    wedding_date { nil }
    deleted_at   { nil }

    after(:build) do |member|
      if member.marital_status == "married" && member.wedding_date.blank?
        member.wedding_date = Faker::Date.backward(days: 3000)
      else
        member.wedding_date = nil
      end
    end

    trait :inactive do
      status { :inactive }
    end

    trait :sympathizer do
      status { :sympathizer }
    end

    trait :active do
      status { :active }
    end

    trait :with_user do
      association :user
    end
  end
end
