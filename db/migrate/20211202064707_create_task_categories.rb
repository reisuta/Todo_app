class CreateTaskCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :task_categories, comment: 'タスクカテゴリー' do |t|
      t.references :task,     null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
