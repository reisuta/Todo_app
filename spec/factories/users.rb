FactoryBot.define do
  factory :user do
    name { 'MyString' }
    email { 'user@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    password_digest {<%= User.digest('password') %>}
  end
end
