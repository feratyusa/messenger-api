class TextsController < ApplicationController
  before_action :set_text, only: [:show, :update, :destroy]
  before_action :set_conversation, only: [:index]

  # GET /conversations/:conversation_id/messages
  def index
    @texts = @conversation.texts.all
    json_response(@texts)
  end

  # GET /texts/1
  def show
    if @text.user.id == Current.user.id
      json_response(@text)
    else
      json_response(nil, :forbidden)
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

    if @text.save
      @conversation.save
      json_response(@text, :created)
    else
      json_response(@text.errors, :unprocessable_entity)
    end
  end

  # # PATCH/PUT /texts/1
  # def update
  #   if @text.update(text_params)
  #     render json: @text
  #   else
  #     render json: @text.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /texts/1
  # def destroy
  #   @text.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text
      @text = Text.find(params[:id])
      if @text == nil
        json.reponse(nil, :not_found)
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
        json_response({"error": "conversation not found"}, :not_found)
        return
      elsif @conversation.first_id != Current.user.id && @conversation.second_id != Current.user.id
        json_response({"error": "forbidden"}, :forbidden)
        return
      end
    end
end
