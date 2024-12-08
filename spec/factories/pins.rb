FactoryBot.define do
    factory :pin do
      sequence(:name) { |n| "タイトル#{n}" }
      sequence(:address) { |n| "住所#{n}" }
      latitude { 35.6585696 }
      longitude { 139.745484 }
      sequence(:body) { |n| "本文#{n}" }
      association :post
    end
  end