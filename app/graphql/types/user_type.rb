module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: true
    field :price_range, Types::PriceRangeInput, null: true
  end
end
