class Task < ApplicationRecord
  has_many :tasks_categories,  dependent: :destroy
  has_many :categories, through: :tasks_categories
  validates :name, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }
  validate :ended_at_validation
  enum priority: { unset: 0, top: 1, middle: 2, bottom: 3 }
  enum status: { waiting: 0, doing: 1, done: 2 }
end

def ended_at_validation
  if ended_at
    return errors.add(:ended_at, 'は現在時間以降を指定してください。') if Time.now > ended_at
  end
end
