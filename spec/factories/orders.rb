require 'faker'
FactoryBot.define do
  factory :order do |f|
    f.product_name { Faker::Name.name}
    f.product_count { Faker::Number.digit}
    f.customer_id { 1 }
  end
end
