class Conversation < ApplicationRecord
    # User Conversation Many-Many Association
    belongs_to :first, class_name: "User"
    belongs_to :second, class_name: "User"

    # Conversation Text One-Many Association
    has_many :texts
end
