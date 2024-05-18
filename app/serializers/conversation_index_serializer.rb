class ConversationIndexSerializer < ActiveModel::Serializer
  attributes :id, :with_user

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
end
