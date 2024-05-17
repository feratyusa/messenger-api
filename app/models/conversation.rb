class Conversation < ApplicationRecord
    # User Conversation Many-Many Association
    has_many :user_conversations
    has_many :users, through: :user_conversations

    # Conversation Text One-Many Association
    has_many :texts
end
