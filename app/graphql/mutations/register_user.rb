# frozen_string_literal: true

module Mutations
  class RegisterUser < Mutations::BaseMutation
    graphql_name "RegisterUser"

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false

    def resolve(args)
      user = User.create!(args)

      # current_user needs to be set so authenticationToken can be returned
      context[:current_user] = user

      MutationResult.call(
        obj: { user: user },
        success: user.persisted?,
        errors: user.errors
      )
    rescue ActiveRecord::RecordInvalid => invalid
      GraphQL::ExecutionError.new(
        "Invalid Attributes for #{invalid.record.class.name}: " \
        "#{invalid.record.errors.full_messages.join(', ')}"
      )
    end
  end
end
