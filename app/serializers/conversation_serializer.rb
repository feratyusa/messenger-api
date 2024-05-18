class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :with_user, :last_message, :unread_count

  def with_user
    if Current.user.id == object.first.id
      {
        id: object.second.id,
        name: object.second.name,
        photo_url: object.second.photo_url
      }
    else
      {
        id: object.first.id,
        name: object.first.name,
        photo_url: object.first.photo_url
      }
    end
  end

  def last_message
    if object.texts[-1].id
    {
      id: object.texts[-1].id,
      sender: sender_user,
      sent_at: object.texts[-1].created_at
    }
    else
      {}
    end
  end

  def sender_user
    {
      id: object.texts[-1].user.id,
      name: object.texts[-1].user.name
    }
  end

  def unread_count
    0
  end
end
