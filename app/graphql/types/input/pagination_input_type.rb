# frozen_string_literal: true
module Types
  module Input
    class PaginationInputType < Types::Input::BaseInputObject
      description 'Input arguments to pagination'

      argument :page, Integer, required: true
      argument :items, Integer, required: true
    end
  end
end
