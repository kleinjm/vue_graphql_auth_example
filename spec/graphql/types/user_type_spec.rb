# frozen_string_literal: true

require "rails_helper"

RSpec.describe Types::UserType do
  it "returns the auth token if current user" do
    user = create(:user)
    variables = { "id" => user.gql_id }

    result = gql_query(
      query: query, variables: variables, context: { current_user: user }
    ).to_h.deep_symbolize_keys

    expect(result.dig(:data, :node, :id)).to eq(user.gql_id)
    expect(result.dig(:data, :node, :authenticationToken)).
      to eq(user.authentication_token)
    expect(result[:errors]).to be_blank
  end

  it "does not return the authenticationToken for non current user" do
    user = create(:user)
    variables = { "id" => user.gql_id }

    result = gql_query(query: query, variables: variables).
      to_h.deep_symbolize_keys

    expect(result.dig(:data, :node)).to be_nil
    expect(result[:errors]).to_not be_blank
  end

  def query
    <<~GQL
      query user($id: ID!) {
        node(id: $id) {
          ... on User {
            id
            firstName
            lastName
            authenticationToken
          }
        }
      }
    GQL
  end
end
