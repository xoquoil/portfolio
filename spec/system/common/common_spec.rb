require 'rails_helper'

RSpec.describe '共通系', type: :system do
  context 'ログイン前' do
    before do
      visit root_path
    end

    describe 'ヘッダー' do
      it 'ヘッダーが正しく表示されていること' do
        expect(page).to have_content('ログイン'), 'ヘッダーに「ログイン」というテキストが表示されていません'
      end
    end

    describe 'フッター' do
      it 'フッターが正しく表示されていること' do
        expect(page).to have_content('このサイトについて'), '「このサイトについて」というテキストが表示されていません'
      end
    end

    describe 'タイトル' do
      it 'タイトルが正しく表示されていること' do
        expect(page).to have_title("PinPoint"), 'トップページのタイトルに「PinPoint」が含まれていません。'
      end
    end
  end

  context 'ログイン後' do
    let(:user) { create(:user) }

    before do
      login_as(user)
    end

    describe 'ヘッダー' do
      it 'ヘッダーが正しく表示されていること' do
        expect(page).to have_content('投稿する'), 'ヘッダーに「投稿」というテキストが表示されていません'
        find('#header-profile').click
        expect(page).to have_content(user.name), 'ヘッダーにユーザー名が表示されていません'
        expect(page).to have_content('ログアウト'), 'ヘッダーに「ログアウト」というテキストが表示されていません'
      end
    end

    describe 'タイトル' do
      it 'タイトルが正しく表示されていること' do
        expect(page).to have_title("PinPoint"), 'トップページのタイトルに「PinPoint」が含まれていません。'
      end
    end
  end
end
