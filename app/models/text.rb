class Text < ApplicationRecord
    validates :message, presence: true

    # Conversation Text Many-One Association
    belongs_to :conversation

    # User Text Many-One Association
    belongs_to :user
end
