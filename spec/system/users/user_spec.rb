require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  it '正しいタイトルが表示されていること' do
    visit '/users/new'
    expect(page).to have_title("新規登録 | PinPoint"), 'ユーザー登録ページのタイトルに「新規登録 | PinPoint」が含まれていません。'
  end

  context '入力情報正常系' do
    it 'ユーザーが新規作成できること' do
      visit '/users/new'
      expect do
        fill_in 'ユーザー名', with: 'たろう'
        fill_in 'メールアドレス', with: 'example@example.com'
        fill_in 'パスワード', with: '12345678'
        fill_in 'パスワード確認', with: '12345678'
        click_button '登録'
        Capybara.assert_current_path("/", ignore_query: true)
      end.to change(User, :count).by(1)
      expect(page).to have_content('ユーザーを登録しました。'), 'フラッシュメッセージ「ユーザーを登録しました。」が表示されていません'
    end
  end

  context '入力情報異常系' do
    it 'ユーザーが新規作成できない' do
      visit '/users/new'
      expect do
        fill_in 'メールアドレス', with: 'example@example.com'
        click_button '登録'
      end.not_to(change(User, :count))
      expect(page).to have_content('ユーザー名を入力してください'), 'フラッシュメッセージ「ユーザー名を入力してください」が表示されていません'
      expect(page).to have_content('パスワードは3文字以上で入力してください'), 'フラッシュメッセージ「パスワードは3文字以上で入力してください」が表示されていません'
      expect(page).to have_content('パスワード確認を入力してください'), 'フラッシュメッセージ「パスワード確認を入力してください」が表示されていません'
    end
  end
end
