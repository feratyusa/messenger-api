require 'rails_helper'

RSpec.describe UserConversation, type: :model do
  before :each do
    @userA = create(:user, name: "Jimbo")
    @userB = create(:user, name: "Bima")
    @conversation = create(:conversation, name: "Conversation 1")
    @conversation.users << @userA
    @conversation.users << @userB
  end

  it "should associate the user with the registration" do
    expect(@conversation.name).to eq 'Conversation 1'
    expect(@conversation.users.length).to eq 2
    expect(@conversation.users.find_by(name: "Jimbo")).to eq @userA
  end

  describe "Connecting Users to Registrations through 1 Factory" do
    before :each do
      @user_and_conversation = create(:user_conversation)
    end

    it "should create a new user and new registration and associate them" do
      expect(@user_and_conversation.user.id).to eq @user_and_conversation.user_id
      expect(@user_and_conversation.conversation.id).to eq @user_and_conversation.conversation_id
    end
  end
end
