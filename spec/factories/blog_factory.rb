FactoryBot.define do
    factory :blog do
      title { Faker::Company.name }
      description { Faker::Lorem.paragraph }
    end
end