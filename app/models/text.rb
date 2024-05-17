class Text < ApplicationRecord
    # Conversation Text Many-One Association
    belongs_to :conversations
end
