class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :update, :destroy]

  # GET /conversations
  def index
    @conversations = Conversation.where(first_id: Current.user.id).or(Conversation.where(second_id: Current.user.id))

    render json: @conversations, include: ["texts"], status: :ok
  end

  # GET /conversations/:id
  def show
    if @conversation.first_id == Current.user.id || @conversation.second_id == Current.user.id
      render json: @conversation, serializer: ConversationIndexSerializer, status: :ok
    else
      render json: {"error" => {"message": :forbidden}}, status: :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
      if @conversation == nil
        render json: {"error" => {"message": :not_found}}, status: :not_found
      end
    end
end
