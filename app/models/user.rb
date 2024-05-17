class User < ApplicationRecord
  # User to User Many-Many Association
  has_many :first_conversations, foreign_key: 'first_id', class_name: 'Conversation'
  has_many :firsts, through: :first_conversations

   # User to User Many-Many Association
   has_many :second_conversations, foreign_key: 'second_id', class_name: 'Conversation'
   has_many :seconds, through: :second_conversations

  # User Text One-Many Association
  has_many :texts

  # encrypt password
  has_secure_password
end
