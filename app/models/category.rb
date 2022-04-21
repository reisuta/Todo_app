class Category < ApplicationRecord
  has_many :tasks_categories, dependent: :destroy
  has_many :tasks, through: :tasks_categories
  validates :name, presence: true, length: { maximum: 50 }
end
