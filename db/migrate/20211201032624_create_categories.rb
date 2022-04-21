class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories, comment: 'カテゴリー' do |t|
      t.string :name, null: false, comment: "カテゴリー名"
      
      t.timestamps
    end
  end
end
