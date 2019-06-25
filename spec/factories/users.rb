# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@gmail.com" }
    first_name { "Test" }
    last_name { "Man" }
    password { "testing123" }
  end
end
