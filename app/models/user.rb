# frozen_string_literal: true

class User < ApplicationRecord
  include GraphQL::Interface

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :database_authenticatable, :token_authenticatable

  validates :first_name, :last_name, presence: true
end
