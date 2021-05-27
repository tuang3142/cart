FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "012346789#{n}" }
    description  { "desc" }
    image_url { "image.png" }
    price { 1 }
  end
end
