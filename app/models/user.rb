class User < ApplicationRecord
  # User Conversation Many-Many Association
  has_many :user_conversations
  has_many :conversations, through: :user_conversations

  # encrypt password
  has_secure_password
end
