FactoryBot.define do
  factory :task, class: Task do
    name { 'todo' }
    body { 'テストデータです' }
    ended_at { DateTime.now + 30 }
    priority { :unset }
    status { :waiting }
    after(:create) do |task|
      task.categories << create(:category, name: 'Ruby')
      task.categories << create(:category, name: 'Python')
    end
  end
end
