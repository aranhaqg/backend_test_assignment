# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'priscila@gmail.com' }
    preferred_price_range { 35000...40000 }
  end
end
