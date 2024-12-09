require 'rails_helper'

RSpec.describe 'ピン', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:like) { create(:like, user: another_user, post: post) }
  let(:pin) { create(:pin, post: post) }

  describe 'ピンのCRUD' do
    describe 'ピンの作成' do
      context 'ログインしている場合' do
        before do
          login_as(user)
          click_on('投稿する')
        end

        it 'ピンが作成できること' do
          fill_in 'タイトル', with: 'ポストタイトル'
          fill_in 'ピンのタイトル', with: 'テストタイトル'
          fill_in '住所', with: 'テスト住所'
          fill_in '緯度', with: 29
          fill_in '経度', with: 154
          fill_in 'ピンの説明', with: 'ピンの説明テスト'
          click_button '投稿'
          expect(page).to have_content('投稿しました'), 'フラッシュメッセージ「投稿しました」が表示されていません'
          click_on('編集')
          expect(page).to have_content('テストタイトル'), '作成したピンのタイトルが表示されていません'
        end

        it 'ピンの作成に失敗すること' do
          fill_in 'タイトル', with: 'ポストタイトル'
          fill_in 'ピンのタイトル', with: ''
          fill_in '住所', with: 'テスト住所'
          fill_in '緯度', with: 29
          fill_in '経度', with: 154
          fill_in 'ピンの説明', with: 'ピンの説明テスト'
          click_button '投稿'
          expect(page).to have_content('投稿に失敗しました'), 'フラッシュメッセージ「投稿に失敗しました」が表示されていません'
          expect(page).to have_content('Pins nameを入力してください'), 'エラーメッセージ「Pins nameを入力してください」が表示されていません'
        end
      end
    end

    describe 'ピンの更新' do
      before do
        post
        pin
      end

      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit edit_post_pin_path(post, pin)
          expect(current_path).to eq('/login'), 'ログインページにリダイレクトされていません'
          expect(page).to have_content 'ログインしてください'
        end
      end

      context 'ログインしている場合' do
        context '自分のピン' do
          before do
            login_as(user)
            visit posts_path
            find("#js-map-for-post-#{post.id}").click
            click_on(pin.name)
          end

          it 'ピンが更新できること' do
            fill_in 'ピンのタイトル', with: '編集後テストタイトル'
            fill_in '住所', with: '編集後テスト住所'
            fill_in '緯度', with: 34
            fill_in '経度', with: 124
            fill_in 'ピンの説明', with: '編集後ピンの説明テスト'
            click_button '投稿'
            Capybara.assert_current_path("/posts/#{post.id}/edit", ignore_query: true)
            expect(current_path).to eq edit_post_path(post)
            expect(page).to have_content('ピンを更新しました'), 'フラッシュメッセージ「ピンを更新しました」が表示されていません'
            expect(page).to have_content('編集後テストタイトル'), '更新後のタイトルが表示されていません'
          end

          it 'ピンの作成に失敗すること' do
            fill_in 'ピンのタイトル', with: ''
            click_button '投稿'
            expect(page).to have_content('ピンの更新に失敗しました'), 'フラッシュメッセージ「ピンの更新に失敗しました」が表示されていません'
          end
        end
      end
    end

    describe 'ピンの削除' do
      before do
        post
        pin
      end

      context '自分のピン' do
        it 'ピンが削除できること' do
          login_as(user)
          visit edit_post_path(post)
          find("#button-delete-pin-#{pin.id}").click
          expect(page).to have_content('ピンを削除しました'), 'フラッシュメッセージ「ピンを削除しました」が表示されていません'
        end
      end
    end
  end
end
