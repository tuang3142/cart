FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "012346789#{n}" }
    description  { "desc" }
    sequence(:image_url) { |n| "#{n}.jpeg" }
    price { 1 }
  end
end
