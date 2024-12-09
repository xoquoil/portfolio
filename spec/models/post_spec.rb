require 'rails_helper'

RSpec.describe Post, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      post = build(:post)
      expect(post).to be_valid
    end
  end

  context 'タイトルが存在しない場合' do
    it '無効であること' do
      post = build(:post, name: nil)
      expect(post).to be_invalid
      expect(post.errors[:name]).to include('を入力してください')
    end
  end

  context 'タイトルが255文字以下の場合' do
    it '有効であること' do
      post = build(:post, name: 'a' * 255)
      expect(post).to be_valid
    end
  end

  context 'タイトルが256文字以上の場合' do
    it '無効であること' do
      post = build(:post, name: 'a' * 256)
      expect(post).to be_invalid
      expect(post.errors[:name]).to include('は255文字以内で入力してください')
    end
  end
end
