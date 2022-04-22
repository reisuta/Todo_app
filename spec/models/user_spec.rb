require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { build(:user) }

  describe '正常系' do
    it '有効なユーザである' do
      expect(user1.valid?).to eq true
    end
  end
end
