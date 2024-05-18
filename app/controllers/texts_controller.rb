class TextsController < ApplicationController
  before_action :set_text, only: [:show, :update, :destroy]
  before_action :set_conversation, only: [:index]

  # GET /conversations/:conversation_id/messages
  def index
    @texts = @conversation.texts.all
    render json: @texts , status: :ok
  end

  # GET /conversations/:conversation_id/messages/:id
  def show
    if @text.user.id == Current.user.id
      render json: @text, status: :ok
    else
      render json: {"error" => {"message": "forbidden"}}, status: :forbidden
    end
  end

  # POST /messages
  def create
    @text_params = params[:text]
    @conversation = Conversation.where("(first_id = :current_id AND second_id = :receiver_id) OR
      (first_id = :receiver_id AND second_id = :current_id)",
      {current_id: Current.user.id, receiver_id: @text_params["user_id"]}).first
    if !@conversation
      @conversation = Conversation.new(first: Current.user, second: User.find_by(id: @text_params["user_id"]))
    end

    @text = Text.new(message: params[:message], user: Current.user, conversation: @conversation)

    if @text.save && @conversation.save
      render json: @text, serializer: TextCreatedSerializer, include: ['conversation', 'unread'], status: :created
    else
      render json: {"error" => {"message": "failed to create text"}}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text
      @text = Text.find(params[:id])
      if @text == nil
        render json: {"error" => {"message": "text not found"}}, status: :not_found
        return
      end
    end

    # Only allow a list of trusted parameters through.
    def text_params
      params.require(:text).permit(:message, :user_id)
    end

    def set_conversation
      @conversation = Conversation.find_by(id: params[:conversation_id])
      if !@conversation
        render json: {"error" => {"message": "conversation not found"}}, status: :not_found
        return
      elsif @conversation.first_id != Current.user.id && @conversation.second_id != Current.user.id
        render json: {"error" => {"message": "forbidden"}}, status: :forbidden
        return
      end
    end
end
