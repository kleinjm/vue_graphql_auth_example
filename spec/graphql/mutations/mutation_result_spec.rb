# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::MutationResult do
  describe ".call" do
    it "returns the full hash with default keys" do
      result = described_class.call(obj: { user: { name: "test" } })

      expect(result.dig(:user, :name)).to eq("test")
      expect(result[:success]).to eq(true)
      expect(result[:errors]).to eq([])
    end

    it "returns the full hash with no object" do
      result = described_class.call

      expect(result.keys).to contain_exactly(:success, :errors)
      expect(result[:success]).to eq(true)
      expect(result[:errors]).to eq([])
    end

    it "returns the full hash with overrides" do
      result = described_class.call(
        obj: { test: "this" },
        success: false,
        errors: ["blah"]
      )

      expect(result[:test]).to eq("this")
      expect(result[:success]).to eq(false)
      expect(result[:errors]).to eq(["blah"])
    end
  end
end
