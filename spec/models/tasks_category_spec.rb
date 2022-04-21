require 'rails_helper'

RSpec.describe TasksCategory, type: :model do
  describe 'リレーション' do
    context 'belongs_to task' do
      it { is_expected.to belong_to(:task) }
    end

    context 'belongs_to category' do
      it { is_expected.to belong_to(:category) }
    end
  end
end
