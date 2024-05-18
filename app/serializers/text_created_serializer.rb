class TextCreatedSerializer < ActiveModel::Serializer
  attributes :id, :message, :sender, :sent_at, :conversation

  def sender
    {
      id: object.user.id,
      name: object.user.name,
      photo_url: object.user.photo_url
    }
  end

  def sent_at
    object.created_at
  end

  def conversation
    {
      id: object.conversation.id,
      with_user: with_user
    }
  end

  def with_user
    if Current.user.id == object.conversation.first.id
      {
        id: object.conversation.first.id,
        name: object.conversation.second.name,
        photo_url: object.conversation.second.photo_url
      }
    else
      {
        id: object.conversation.first.id,
        name: object.conversation.first.name,
        photo_url: object.conversation.first.photo_url
      }
    end
  end
end
