require 'rails_helper'

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many(:texts) }
    it { should have_many(:firsts).class_name(User) }
    it { should have_many(:seconds).class_name(User) }
  end
end
