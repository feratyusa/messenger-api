class TextSerializer < ActiveModel::Serializer
  attributes :id, :message, :sender, :sent_at

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
end
