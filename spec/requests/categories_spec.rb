require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let!(:category1) { create(:category) }
  let!(:category2) { create(:category, name: 'Rust') }
  let(:category_params) { attributes_for(:category) }


  describe 'GET /categories' do
    context '正常系' do
      it '一覧画面の適切なステータスコードが返ってくること' do
        get categories_path
        expect(response).to have_http_status(200)
      end
    end

    context '検索機能処理' do
      it 'category1の検索文字列に部分一致すること' do
        get categories_path, params: { q: { name_cont: 'カテ' } }
        expect(response.body).to include(category1.name)
      end

      it 'category2の検索結果が表示されないこと' do
        get categories_path, params: { q: { name_cont: 'カテ' } }
        expect(response.body).not_to include(category2.name)
      end

      it '検索文字列が一致しない場合、検索結果が表示されないこと' do
        get categories_path, params: { q: { name_cont: 'ww' } }
        expect(response.body).not_to include(category1.name)
        expect(response.body).not_to include(category2.name)
      end

      it '検索文字列が空白の場合、すべての検索結果を返すこと' do
        get categories_path, params: { q: { name_cont: '' } }
        expect(response.body).to include(category1.name)
        expect(response.body).to include(category2.name)
      end
    end
  end

  describe 'Get /categories/:id' do
    it '詳細画面の適切なステータスコードが返ってくること' do
      get category_path(category1.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get /categories/new' do
    it '登録画面の適切なステータスコードが返ってくること' do
      get new_category_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get /categories/:id/edit' do
    it '編集画面の適切なステータスコードが返ってくること' do
      get edit_category_path(category1.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'Post /categories' do
    context '正常系の場合' do
      it '適切なステータスコードを返す' do
        post categories_path, params: { category: category_params }
        expect(response).to have_http_status(302)
      end

      it '一覧画面にリダイレクトされる' do
        post categories_path, params: { category: category_params }
        expect(response).to redirect_to(categories_path)
      end

      it 'レコードの値が一つ増える' do
        expect do
          post categories_path, params: { category: category_params }
        end.to change { Category.count }.by(1)
      end
    end

    context '異常系の場合' do
      before do
        category_params[:name] = ''
      end
      it '適切なステータスコードを返す' do
        post categories_path, params: { category: category_params }
        expect(response).to have_http_status(200)
      end

      it '登録画面にレンダリングされること' do
        post categories_path, params: { category: category_params }
        expect(response).to render_template :new
      end
    end
  end

  describe 'Patch /categories/:id' do
    let(:category_new_params) { { name: '' } }
    let(:category_update_params) { { name: 'next_category' } }
    context '正常系の場合' do
      it '適切なステータスコードを返す' do
        patch category_path(category1.id), params: { category: category_update_params }
        expect(response).to have_http_status(302)
      end

      it 'レコードの値が意図したものに更新される' do
        expect do
          patch category_path(category1.id), params: { category: category_update_params }
        end.to change { category1.reload.name }
      end

      it '詳細画面にリダイレクトされる' do
        patch category_path(category1.id), params: { category: category_update_params }
        expect(response).to redirect_to(category_path)
      end
    end

    context '異常系の場合' do
      it '適切なステータスコード' do
        patch category_path(category1.id), params: { category: category_new_params }
        expect(response).to have_http_status(200)
      end

      it '値が更新されていないこと' do
        patch category_path(category1.id), params: { category: category_new_params }
        expect(category1.name).to eq 'カテゴリー1'
      end

      it '編集画面にレンダリングされる' do
        patch category_path(category1.id), params: { category: category_new_params }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'Delete/categories/:id' do
    it 'レコードの値が一つ減ること' do
      expect do
        delete category_path(category1.id)
      end.to change { Category.count }.by(-1)
    end

    it '一覧画面にリダイレクトされること' do
      delete category_path(category1.id)
      expect(response).to redirect_to(categories_path)
    end
  end
end
