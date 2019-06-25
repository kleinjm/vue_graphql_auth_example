# frozen_string_literal: true

require "rails_helper"

RSpec.describe VueGraphqlAuthExampleSchema do
  describe ".resolve_type" do
    it "resolves the given type dynamically" do
      [User].each do |klass|
        expect(described_class.resolve_type(nil, klass.new, nil).name).
          to eq(klass.name)
      end
    end

    it "raises an error for unknown type" do
      expect { described_class.resolve_type(nil, RSpec, nil) }.
        to raise_error(RuntimeError, "Unexpected object: RSpec")
    end
  end

  describe ".id_from_object" do
    it "returns the gql id for the given object" do
      user = User.new(id: 123)
      id = described_class.id_from_object(user, User)

      expect(Base64.decode64(id)).to eq("User-123")
    end
  end

  describe ".object_from_id" do
    it "returns an instance of the object from the given gql id" do
      user = create(:user)
      expect(described_class.object_from_id(user.gql_id, nil)).to eq(user)
    end
  end
end
