FactoryBot.define do
  factory :order do
    name { "Alice" }
    address { "In the Wonderland" }
    email { "alice@wonder.land" }
    payment_method { "Credit card" }
  end
end
