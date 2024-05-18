require 'rails_helper'

RSpec.describe Text, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:conversation) }
  it { should have_one(:unread) }

  context "after create text" do
    it "should push new unread to conversation based on receiver user id" do
      @userA = create(:user)
      @userB = create(:user)
      @convo = create(:conversation, first: @userA, second: @userB)
      @texts = create_list(:text, 5, user: @userA, conversation: @convo)
      expect(@convo.unreads.where("user_id = :user_id",{user_id: @userB.id}).length).to eq 5
    end
  end
end
