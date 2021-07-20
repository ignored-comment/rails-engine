FactoryBot.define do
    factory :item do
      name { Faker::Commerce.material }
      description { Faker::Lorem.sentence }
      unit_price { Faker::Commerce.price(range: 0..1000.0, as_string: true) }
      merchant
    end
  end