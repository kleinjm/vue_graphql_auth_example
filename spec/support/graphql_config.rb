# frozen_string_literal: true

RSpec.configure do |config|
  # infer the integrations dir so we don't need to add the tag to each one
  config.define_derived_metadata(
    file_path: Regexp.new("/spec/graphql/")
  ) do |metadata|
    metadata[:type] = :gql
  end
end
