module Types
  class CarType < Types::BaseObject
    field :id, ID, null: false
    field :model, String, null: true
    field :price, Integer, null: true
    field :brand, Types::BrandType, null: true
  end
end
