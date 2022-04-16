FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
      confirmed_at { Time.now }
      factory :user_with_blogs do
        after(:create) do |user|
          create_list :blog, 3, user_id: user.id
        end
      end
    end
end