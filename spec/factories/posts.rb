FactoryBot.define do
    factory :post do
      sequence(:name) { |n| "タイトル#{n}" }
      association :user
    end
  end