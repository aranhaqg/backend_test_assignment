module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :recommended_cars, String, null: false do
      description 'Return recommended cars based on user preferences'
      argument :user_id, ID, required: true
      argument :pagination, Types::Input::PaginationInputType, required: false, default_value: nil
    end

    #TODO add resolver
    def recommended_cars
      "Hello World!"
    end
  end
end
