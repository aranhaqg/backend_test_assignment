# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    model { 'Arna' }
    price { 39938 }
    brand
  end
end
