FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "012346789#{n}" }
    description  { "desc" }
    sequence(:image_url) { "0.jpeg" }
    price { 1 }
  end
end
