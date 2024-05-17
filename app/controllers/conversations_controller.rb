class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :update, :destroy]

  # GET /conversations
  def index
    @conversations = Current.user.conversations

    json_response(@conversations)
  end

  # GET /conversations/1
  def show
    if @conversation.users.find_by(id: Current.user.id)
      json_response(@conversation)
    else
      json_response(nil, :forbidden)
    end
  end

  # POST /conversations
  # def create
  #   @conversation = Conversation.new(conversation_params)

  #   if @conversation.save
  #     render json: @conversation, status: :created, location: @conversation
  #   else
  #     render json: @conversation.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /conversations/1
  # def update
  #   if @conversation.update(conversation_params)
  #     render json: @conversation
  #   else
  #     render json: @conversation.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /conversations/1
  # def destroy
  #   @conversation.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
      if @conversation == nil
        json_response(nil, :not_found)
      end
    end

    # Only allow a list of trusted parameters through.
    # def conversation_params
    #   params.require(:conversation).permit(:name)
    # end
end
