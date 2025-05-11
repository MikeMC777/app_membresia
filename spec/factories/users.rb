FactoryBot.define do
  factory :user do
    association :member
    email { Faker::Internet.email }
    password { "password123" }

    transient do
      roles { [] } # permite pasar un array: create(:user, roles: [:admin])
    end

    after(:create) do |user, evaluator|
      evaluator.roles.each do |role_name|
        role = Role.find_or_create_by!(name: role_name.to_s)
        UserRole.create!(user: user, role: role) # ajusta según tu modelo
      end
    end
  end
end

