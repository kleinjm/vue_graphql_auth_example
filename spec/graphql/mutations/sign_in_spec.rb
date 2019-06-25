# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::SignIn do
  it "signs in the user" do
    variables = {
      "email" => "kleinjm007@gmail.com",
      "password" => "testing123"
    }
    user = create(:user, **variables.symbolize_keys)

    result = gql_query(query: mutation, variables: variables).
      to_h.deep_symbolize_keys.dig(:data, :signIn)

    user.reload
    expect(result.dig(:user, :id)).to eq(user.gql_id)
    expect(result.dig(:user, :authenticationToken)).
      to eq(user.authentication_token)
    expect(result[:success]).to eq(true)
    expect(result[:errors]).to be_blank
  end

  it "raises error for incorrect email/password" do
    variables = {
      "email" => "kleinjm007@gmail.com",
      "password" => "testing123"
    }
    user_variables = { email: variables["email"], password: "wrongpass1" }
    create(:user, **user_variables)

    result = gql_query(query: mutation, variables: variables).
      to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq("Incorrect Email/Password")
    expect(result.dig(:data, :signIn)).to be_blank
  end

  it "raises error for missing user" do
    variables = {
      "email" => "kleinjm007@gmail.com",
      "password" => "testing123"
    }

    result = gql_query(query: mutation, variables: variables).
      to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).
      to eq("User not registered on this application")
    expect(result.dig(:data, :signIn)).to be_blank
  end

  def mutation
    <<~GQL
      mutation signIn($email: String!, $password: String!) {
        signIn(input: { email: $email, password: $password }) {
          user {
            id
            firstName
            lastName
            authenticationToken
          }
          success
          errors
        }
      }
    GQL
  end
end
