class AddColumnTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :priority, :integer, default: 0, null: false, comment: "優先順位"
    add_column :tasks, :ended_at, :datetime, comment: "終了期限"
    add_column :tasks, :status, :integer, default: 0, null: false, comment: "タスク状態"
  end
end
