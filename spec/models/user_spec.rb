require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { build(:user) }

  describe 'validation' do
    context '正常系' do
      it '有効なユーザである' do
        expect(user1.valid?).to eq true
      end
    end

    context '異常系' do
      let(:nil_name) { build(:user, name: '') }
      let(:nil_email) { build(:user, email: '') }
      let(:user2) { build(:user, name: ('a' * 51)) }
      let(:user3) { build(:user, email: ('a' * 244 + '@example.com')) }
      let(:invalid_email) { build(:user, email: 'user@example,com') }
      let(:blank_password) { build(:user, password: (' ' * 6), password_confirmation: (' ' * 6)) }
      let(:min_password) { build(:user, password: ('a' * 5), password_confirmation: ('a' * 5)) }

      it '名前が空白の場合、登録できない' do
        expect(nil_name.valid?).to eq false
      end

      it '名前が51文字以上の場合、登録できない' do
        expect(user2.valid?).to eq false
      end

      it 'emailが空白の場合、登録できない' do
        expect(nil_email.valid?).to eq false
      end

      it 'emailが255文字以上の場合、登録できない' do
        expect(user3.valid?).to eq false
      end

      it 'emailの形式が不適切の場合、登録できない' do
        expect(invalid_email.valid?).to eq false
      end

      it 'emailが重複している場合、登録できない' do
        @user = build(:user)
        duplicate_user = @user.dup
        @user.save
        expect(duplicate_user.valid?).to eq false
      end

      it 'passwordが空のとき、登録できない' do
        expect(blank_password.valid?).to eq false
      end

      it 'passwordが5文字以内のとき、登録できない' do
        expect(min_password.valid?).to eq false
      end
    end
  end
end
