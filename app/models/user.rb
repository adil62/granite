# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token :authentication_token

  MAX_NAME_LENGTH = 255

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze

  has_many :assigned_tasks, foreign_key: :assigned_user_id, class_name: "Task"

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: MAX_EMAIL_LENGTH }

  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :password_confirmation, presence: true, on: :create

  before_save :to_lowercase

  private

    def to_lowercase
      email.downcase!
    end
end
