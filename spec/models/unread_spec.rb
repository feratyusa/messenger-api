require 'rails_helper'

RSpec.describe Unread, type: :model do
  it { should belong_to(:conversation) }
  it { should belong_to(:text) }
end
