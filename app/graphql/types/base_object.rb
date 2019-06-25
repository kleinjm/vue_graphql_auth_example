# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    # Used by Relay to lookup objects by UUID:
    add_field(GraphQL::Types::Relay::NodeField)

    # Fetches a list of objects given a list of IDs
    add_field(GraphQL::Types::Relay::NodesField)
  end
end
