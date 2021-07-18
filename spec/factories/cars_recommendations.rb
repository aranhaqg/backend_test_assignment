# frozen_string_literal: true

FactoryBot.define do
  factory :cars_recommendation do
    user
    car
    rank_score { 0.945 }
  end
end
