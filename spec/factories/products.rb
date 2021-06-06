# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "Rails Tutorial 10#{n}" }
    description { "From rookie to rock in no time" }
    sequence(:image_url) { "0.jpeg" }
    sequence(:price) { |n| n }
  end
end
