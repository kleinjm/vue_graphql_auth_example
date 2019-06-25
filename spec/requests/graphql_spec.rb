# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /graphql" do
  it "executes the given query or mutation" do
    stub_schema_execute

    variables = { "myVariables" => "test" }
    query = "someLongQuery(input: { id: ID } { users { id name } })"
    operation_name = "signIn"

    post graphql_path(
      format: :json,
      variables: variables.to_json,
      query: query,
      operationName: operation_name
    )

    expect(VueGraphqlAuthExampleSchema).to have_received(:execute).with(
      query,
      variables: variables,
      context: { current_user: nil },
      operation_name: operation_name
    )
    expect(json_body).to eq("success" => true)
  end

  it "sets the current_user context" do
    stub_schema_execute
    user = sign_in_user

    post graphql_path(format: :json)

    expect(VueGraphqlAuthExampleSchema).to have_received(:execute).with(
      nil,
      variables: {},
      context: { current_user: user },
      operation_name: nil
    )
    expect(json_body).to eq("success" => true)
  end

  # ...

  def stub_schema_execute
    allow(VueGraphqlAuthExampleSchema).
      to receive(:execute).and_return(success: true)
  end

  def json_body
    json = JSON.parse(response.body)
    json.is_a?(Hash) ? json.with_indifferent_access : json # could be an array
  end
end
