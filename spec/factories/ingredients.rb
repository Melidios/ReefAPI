FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
    item
  end
end
