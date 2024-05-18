class Unread < ApplicationRecord
  belongs_to :conversation
  belongs_to :text
end
