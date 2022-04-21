class ChangeTaskCategoriesToTasksCategories < ActiveRecord::Migration[6.1]
  def change
    rename_table :task_categories, :tasks_categories
  end
end
