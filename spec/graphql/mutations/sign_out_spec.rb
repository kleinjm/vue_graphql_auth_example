# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::SignOut do
  it "signs out the current user" do
    user = create(:user)
    auth_token = user.authentication_token

    result = gql_query(query: mutation, context: { current_user: user }).
      to_h.deep_symbolize_keys.dig(:data, :signOut)

    user.reload
    expect(result.dig(:user, :id)).to eq(user.gql_id)
    expect(result.dig(:user, :authenticationToken)).to_not eq(auth_token)
    expect(user.authentication_token).to_not eq(auth_token)
    expect(result[:success]).to eq(true)
    expect(result[:errors]).to be_blank
  end

  it "raises error for user not signed in" do
    result = gql_query(query: mutation).to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq("User not signed in")
    expect(result.dig(:data, :signIn)).to be_blank
  end

  def mutation
    <<~GQL
      mutation signOut {
        signOut(input: {}) {
          user {
            id
            authenticationToken
          }
          success
          errors
        }
      }
    GQL
  end
end
