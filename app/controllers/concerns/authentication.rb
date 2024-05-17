module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  private
    def authenticate
      header = request.headers['Authorization']
      if header
          token = header.split(" ").last
          if authenticated_user = User.find_by(id: JsonWebToken.decode(token)["user_id"])
            Current.user = authenticated_user
          else
            render json: {"error": JsonWebToken.decode(token)}, status: :unauthorized
          end
      end

    end
end
