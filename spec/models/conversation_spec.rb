require 'rails_helper'

RSpec.describe Conversation, type: :model do
  before :each do
    @userA = create(:user, name: "Jimbo")
    @userB = create(:user, name: "Bima")
    @conversation = create(:conversation, first: @userA, second: @userB)
  end

  it "should associate the user with other user" do
    expect(@conversation.first.id).to eq @userA.id
    expect(@conversation.second.id).to eq @userB.id
  end
end
