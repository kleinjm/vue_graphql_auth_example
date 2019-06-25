# frozen_string_literal: true

# Note the path of this file must be graph_ql, not graphql
module GraphQL
  module Interface
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend(ClassMethods)
    end

    module InstanceMethods
      def gql_id
        GraphQL::Schema::UniqueWithinType.encode(self.class.name, id)
      end
    end

    module ClassMethods
      def find_by_gql_id(gql_id)
        _type_name, object_id = GraphQL::Schema::UniqueWithinType.decode(gql_id)

        find(object_id)
      end

      def find_by_gql_ids(gql_ids)
        ids = gql_ids.map do |gql_id|
          GraphQL::Schema::UniqueWithinType.decode(gql_id).last
        end

        where(id: ids)
      end
    end
  end
end
