# frozen_string_literal: true

module Types
  module Input
    class BaseInputObject < GraphQL::Schema::InputObject
      argument_class Types::BaseArgument
    end
  end
end
