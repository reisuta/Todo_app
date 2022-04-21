require 'rails_helper'

RSpec.describe Task, type: :model do
   describe '正常系' do
     context '値が存在するか' do
       it '存在する' do
         is_expected.to validate_presence_of :name
         is_expected.to validate_presence_of :body
       end
     end

     context '最大文字数以内に収まっているか' do
       it '収まっている' do
         is_expected.to validate_length_of(:name).is_at_most(50)
         is_expected.to validate_length_of(:body).is_at_most(1000)
       end
     end
   end

   describe '異常系' do
     let(:nil_name) { build(:task, name: nil) }
     let(:nil_body) { build(:task, body: nil) }
     let(:max_name) { build(:task, name: 'a'*51) }
     let(:max_body) { build(:task, body: 'a'*1001) }
     context 'nameの値が存在しない場合' do
       it 'エラーを返す' do
         expect(nil_name.valid?).to eq false
       end

       it '日本語でエラーメッセージを返す' do
         nil_name.valid?
         expect(nil_name.errors.full_messages).to eq ['タスク名を入力してください']
       end
     end

     context 'bodyの値が存在しない場合' do
       it 'エラーを返す' do
         expect(nil_body.valid?).to eq false
       end

       it '日本語でエラーメッセージを返す' do
        nil_body.valid?
        expect(nil_body.errors.full_messages).to eq ['本文を入力してください']
      end
     end

     context 'nameの最大文字数が超えている場合' do
       it 'エラーを返す' do
         expect(max_name.valid?).to eq false
       end

       it '日本語でエラーメッセージを返す' do
        max_name.valid?
        expect(max_name.errors.full_messages).to eq ['タスク名は50文字以内で入力してください']
      end
     end

     context 'bodyの最大文字数が超えている場合' do
       it 'エラーを返す' do
         expect(max_body.valid?).to eq false
       end

       it '日本語でエラーメッセージを返す' do
        max_body.valid?
        expect(max_body.errors.full_messages).to eq ['本文は1000文字以内で入力してください']
      end
     end
   end
 end
