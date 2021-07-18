# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bravado::RecommendedCarsService, type: :service do
  describe '#by_user_id' do
    let(:car) { create(:car) }
    let(:user) { create(:user) }
    let(:cars_recommendation) { create(:cars_recommendation, car: car, user: user) }
    let(:parsed_response) do
      [
        { 'car_id': car.id, 'rank_score': 0.945 },
      ]
    end

    let(:http_response) { Struct.new(:code, :parsed_response) }
    let(:expected_response) { http_response.new(200, parsed_response) }

    let(:car_recomendations_service) { described_class.new(user.id).by_user_id }

    before do
      allow_any_instance_of(Bravado::RecommendedCarsService).to receive(:by_user_id).and_return(expected_response)
    end

    it 'with success request' do
      expect(car_recomendations_service.parsed_response.first[:car_id]).to eq(car.id)
      expect(car_recomendations_service.parsed_response.first[:rank_score]).to eq(0.945)
      expect(car_recomendations_service.code).to eq(200)
    end
  end
end
