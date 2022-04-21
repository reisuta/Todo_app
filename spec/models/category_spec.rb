require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '正常系' do
    context '値が存在するか' do
      it '存在する' do
        is_expected.to validate_presence_of :name
      end
    end

    context '最大文字数以内に収まっているか' do
      it '収まっている' do
        is_expected.to validate_length_of(:name).is_at_most(50)
      end
    end
  end

  describe '異常系' do
    let(:nil_name) { build(:category, name: nil) }
    let(:max_name) { build(:category, name: 'a'*51) }
    context '値が存在しない場合' do
      it 'エラーを返す' do
        expect(nil_name.valid?).to eq false
      end

      it '日本語でエラーメッセージを返す' do
        nil_name.valid?
        expect(nil_name.errors.full_messages).to eq ['カテゴリー名を入力してください']
      end
    end

    context '最大文字数を超えている場合' do
      it 'エラーを返す' do
        expect(max_name.valid?).to eq false
      end

      it '日本語でエラーメッセージを返す' do
        max_name.valid?
        expect(max_name.errors.full_messages).to eq ['カテゴリー名は50文字以内で入力してください']
      end
    end
  end
end
