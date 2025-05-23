require 'rails_helper'

RSpec.describe Pin, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      pin = build(:pin)
      expect(pin).to be_valid
    end
  end

  context 'タイトルが存在しない場合' do
    it '無効であること' do
      pin = build(:pin, name: nil)
      expect(pin).to be_invalid
      expect(pin.errors[:name]).to include('を入力してください')
    end
  end

  context 'タイトルが255文字以下の場合' do
    it '有効であること' do
      pin = build(:pin, name: 'a' * 255)
      expect(pin).to be_valid
    end
  end

  context 'タイトルが256文字以上の場合' do
    it '無効であること' do
      pin = build(:pin, name: 'a' * 256)
      expect(pin).to be_invalid
      expect(pin.errors[:name]).to include('は255文字以内で入力してください')
    end
  end

  context '本文が65535文字以内の場合' do
    it '有効であること' do
      pin = build(:pin, body: 'a' * 65_535)
      expect(pin).to be_valid
    end
  end

  context '本文が65536文字以上の場合' do
    it '無効であること' do
      pin = build(:pin, body: 'a' * 65_536)
      expect(pin).to be_invalid
      expect(pin.errors[:body]).to include('は65535文字以内で入力してください')
    end
  end
end
