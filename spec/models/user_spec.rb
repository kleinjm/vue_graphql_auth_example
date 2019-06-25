# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  describe "callbacks" do
    it "creates an auth token before saving if one does not exist" do
      # See: Devise initializer `config.http_authenticatable = true`
      user = User.new(attributes_for(:user))
      expect(user.authentication_token).to be_blank

      user.save

      expect(user.reload.authentication_token).to_not be_blank
    end
  end
end
