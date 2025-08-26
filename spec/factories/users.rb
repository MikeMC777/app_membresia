FactoryBot.define do
  factory :user do
    association :member
    email { Faker::Internet.email }
    password { "password123" }


    trait :admin do
      after(:create) do |user|
        # Asegúrate de que exista el role 'admin'
        role = Role.find_or_create_by!(name: 'admin')
        # Crea el join user_role
        create(:user_role, user: user, role: role)
      end
    end

    # Puedes añadir otros traits para secretary, programmer, etc.
    trait :secretary do
      after(:create) do |user|
        role = Role.find_or_create_by!(name: 'secretary')
        create(:user_role, user: user, role: role)
      end
    end

    # Puedes añadir otros traits para secretary, programmer, etc.
    trait :programmer do
      after(:create) do |user|
        role = Role.find_or_create_by!(name: 'programmer')
        create(:user_role, user: user, role: role)
      end
    end

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

