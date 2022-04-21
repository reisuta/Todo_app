require 'rails_helper'

RSpec.describe 'TasksController', type: :request do
  let!(:task1) { create(:task, name: 'zzzzz', body: 'test', ended_at: DateTime.now + 50, priority: :top, status: :doing) }
  let!(:task2) { create(:task) }
  let(:category1) { create(:category, name: 'category1') }
  let(:category2) { create(:category, name: 'category2') }
  let(:category3) { create(:category) }
  before do
    create_list(:task, 5, name: 'vim', priority: :top, status: :doing)
  end

  describe 'GET /tasks' do
    context '正常系' do
      it '一覧画面の適切なステータスコードが返ってくること' do
        get tasks_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ソート処理' do
      it 'ソートしていない際に、最初にtask1が表示されている' do
        get tasks_path
        expect(Task.first).to eq task1
      end

      it 'タイトルでのソートが正常に実行されている' do
        get tasks_path, params: { q: { s: 'name asc' } }
        s = controller.instance_variable_get('@tasks')
        expect(s.first).to eq task2
      end

      it '終了期限でのソートが正常に実行されている' do
        get tasks_path, params: { q: { s: 'ended_at asc' } }
        s = controller.instance_variable_get('@tasks')
        expect(s.first).to eq task2
      end

      it '優先順位でのソートが正常に実行されている' do
        get tasks_path, params: { q: { s: 'priority asc' } }
        s = controller.instance_variable_get('@tasks')
        expect(s.first).to eq task2
      end

      it 'タスク状態でのソートが正常に実行されている' do
        get tasks_path, params: { q: { s: 'status asc' } }
        s = controller.instance_variable_get('@tasks')
        expect(s.first).to eq task2
      end
    end

    context 'ページネーション処理' do
      let!(:task3) { create(:task, name: 'yml', priority: :top, status: :doing) }

      it '1ページ目にtask3が表示されていないこと' do
        get tasks_path
        expect(response.body).not_to include(task3.name)
      end

      it '正常にページネーションされている' do
        get tasks_path, params: { page: 2 }
        expect(response.body).to include(task3.name)
      end
    end

    context '検索機能処理' do
      it 'タスク名の検索文字列に部分一致すること' do
        get tasks_path, params: { q: { name_cont: 'to' } }
        expect(response.body).to include(task2.name)
      end

      it 'タスク本文の検索文字列に部分一致すること' do
        get tasks_path, params: { q: { body_cont: 'テスト' } }
        s = controller.instance_variable_get('@tasks')
        expect(s).to include(task2)
      end

      it 'カテゴリー名の検索文字列に部分一致すること' do
        get tasks_path, params: { q: { categories_name_cont: 'Ru' } }
        s = controller.instance_variable_get('@tasks')
        expect(s).to include(task2)
      end

      it '検索文字列が一致しない場合、空の配列を返すこと' do
        get tasks_path, params: { q: { name_cont: 'www' } }
        expect(response.body).not_to include(task1.name)
        expect(response.body).not_to include(task2.name)
      end

      it '検索文字列が空白の場合、すべての配列を返すこと' do
        get tasks_path, params: { q: { name_cont: '' } }
        expect(response.body).to include(task1.name)
        expect(response.body).to include(task2.name)
      end
    end

    describe 'Get /tasks/:id' do
      it '詳細画面の適切なステータスコードが返ってくること' do
        get task_path(task2.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'Get /tasks/new' do
      it '登録画面の適切なステータスコードが返ってくること' do
        get new_task_path
        expect(response).to have_http_status(200)
      end
    end

    describe 'Get /tasks/:id/edit' do
      it '編集画面の適切なステータスコードが返ってくること' do
        get edit_task_path(task2.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'Post /tasks' do
      let(:task_params) { { name: 'todo', body: 'TEST', category_ids: [category3.id] } }
      context '正常系の場合' do
        it '適切なステータスコードを返す' do
          post tasks_path, params: { task: task_params }
          expect(response).to have_http_status(302)
        end

        it '一覧画面にリダイレクトされる' do
          post tasks_path, params: { task: task_params }
          expect(response).to redirect_to(root_path)
        end

        it 'Taskモデルのレコードの値が一つ増える' do
          expect do
            post tasks_path, params: { task: task_params }
          end.to change { Task.count }.by(1)
        end

        it 'TasksCategoryモデルのレコードの値が一つ増える' do
          expect do
            post tasks_path, params: { task: task_params }
          end.to change { TasksCategory.count }.by(1)
        end
      end

      context '異常系の場合' do
        before do
          task_params[:name] = ''
        end
        it '適切なステータスコードを返す' do
          post tasks_path, params: { task: task_params }
          expect(response).to have_http_status(200)
        end

        it '登録画面にレンダリングされること' do
          post tasks_path, params: { task: task_params }
          expect(response).to render_template :new
        end
      end
    end

    describe 'Patch /tasks/:id' do
      let(:task_update_params) { { name: 'next_todo', body: 'Test', category_ids: [category1.id, category2.id] } }
      context '正常系の場合' do
        it '適切なステータスコードを返す' do
          patch task_path(task2.id), params: { task: task_update_params }
          expect(response).to have_http_status(302)
        end

        it 'レコードの値が意図したものに更新される' do
          patch task_path(task2.id), params: { task: task_update_params }
          expect(task2.reload[:name]).to eq 'next_todo'
          expect(task2.reload[:body]).to eq 'Test'
          expect(task2.categories[0].id).to eq category1.id
          expect(task2.categories[1].id).to eq category2.id
        end

        it '詳細画面にリダイレクトされる' do
          patch task_path(task2.id), params: { task: task_update_params }
          expect(response).to redirect_to(task_path)
        end
      end

      context '異常系の場合' do
        before do
          task_update_params[:name] = ''
        end
        it '適切なステータスコード' do
          patch task_path(task2.id), params: { task: task_update_params }
          expect(response).to have_http_status(200)
        end

        it '値が更新されていないこと' do
          expect do
            patch task_path(task2.id), params: { task: task_update_params }
          end.not_to change(task2.reload, :updated_at)
        end

        it '編集画面にレンダリングされる' do
          patch task_path(task2.id), params: { task: task_update_params }
          expect(response).to render_template :edit
        end
      end
    end

    describe 'Delete/tasks/:id' do
      it 'レコードの値が一つ減ること' do
        expect do
          delete task_path(task2.id)
        end.to change { Task.count }.by(-1)
      end

      it '一覧画面にリダイレクトされること' do
        delete task_path(task2.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
