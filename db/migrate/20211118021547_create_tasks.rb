class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks, comment: 'タスク' do |t|
      t.string :name, null: false, comment: "タスク名"
      t.text   :body, null: false, comment: "タスク本文"

      t.timestamps
    end
  end
end
