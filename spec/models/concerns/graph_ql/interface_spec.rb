# frozen_string_literal: true

require "rails_helper"

RSpec.describe GraphQL::Interface do
  class MockClass
    include GraphQL::Interface

    attr_reader :id

    def initialize(id = 123)
      @id = id
    end

    def self.find(id)
      new(id.to_i)
    end

    def self.where(id_hash)
      id_hash[:id].map { |id| new(id.to_i) }
    end
  end

  describe "#gql_id" do
    it "returns the gql id" do
      expect(MockClass.new.gql_id).to be_a(String)
      expect(MockClass.new.gql_id.length).to eq(20)
      expect(Base64.decode64(MockClass.new.gql_id)).to eq("MockClass-123")
    end
  end

  describe ".find_by_gql_id" do
    it "finds the MockClass with the given gql id" do
      mock_class = MockClass.new(456)

      expect(MockClass.find_by_gql_id(mock_class.gql_id).id).
        to eq(mock_class.id)
    end

    it "raises an error when given invalid id" do
      expect { MockClass.find_by_gql_id("bad-id") }.
        to raise_error(ArgumentError)
    end
  end

  describe ".find_by_gql_ids" do
    it "finds the MockClass with the given gql ids" do
      mock_class = MockClass.new(456)

      expect(MockClass.find_by_gql_ids([mock_class.gql_id]).first.id).
        to eq(mock_class.id)
    end
  end
end
