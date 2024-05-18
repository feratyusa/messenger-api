class Text < ApplicationRecord
    validates :message, presence: true
    after_create :push_unread

    # Conversation Text Many-One Association
    belongs_to :conversation

    # User Text Many-One Association
    belongs_to :user

    # Text Unread One-One Association
    has_one :unread

    def push_unread
        Unread.create(
            text: self,
            conversation: self.conversation,
            user_id: self.conversation.first_id == self.user_id ? self.conversation.second_id : self.conversation.first_id
        )
    end
end
