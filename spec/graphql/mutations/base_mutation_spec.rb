# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::BaseMutation do
  describe "#authorize_user" do
    it "returns true if user is signed in" do
      mutation = Mutations::BaseMutation.new(
        object: nil, context: { current_user: double }
      )

      expect(mutation.send(:authorize_user)).to eq(true)
    end

    it "raise an error if not signed in" do
      mutation = Mutations::BaseMutation.new(
        object: nil, context: { current_user: nil }
      )

      expect { mutation.send(:authorize_user) }.
        to raise_error(GraphQL::ExecutionError, "User not signed in")
    end
  end
end
