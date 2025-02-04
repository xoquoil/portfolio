require 'rails_helper'

RSpec.describe 'プロフィール', type: :system do
  let(:user) { create(:user) }

  before { login_as(user) }

  it 'プロフィールの詳細が見られること' do
    visit posts_path
    find('#header-profile').click
    click_on user.name
    Capybara.assert_current_path("/profile", ignore_query: true)
    expect(current_path).to eq(profile_path), 'プロフィールページに遷移していません'
    expect(page).to have_content(user.email), 'プロフィールページにメールアドレスが表示されていません'
    expect(page).to have_content(user.name), 'プロフィールページにニックネームが表示されていません'
  end

  it 'プロフィールの編集ができること' do
    visit profile_path
    click_on '編集'
    Capybara.assert_current_path("/profile/edit", ignore_query: true)
    expect(current_path).to eq(edit_profile_path), 'プロフィール編集ページに遷移していません'
    fill_in 'ニックネーム', with: '編集後ニックネーム'
    click_button '更新'
    Capybara.assert_current_path("/profile", ignore_query: true)
    expect(current_path).to eq(profile_path), 'プロフィールページに遷移していません'
    expect(page).to have_content('ユーザー情報を更新しました'), 'フラッシュメッセージ「ユーザー情報を更新しました」が表示されていません'
    expect(page).to have_content('編集後ニックネーム'), '更新後のニックネームが表示されていません'
  end

  it 'プロフィールの編集に失敗すること' do
    visit profile_path
    click_on '編集'
    Capybara.assert_current_path("/profile/edit", ignore_query: true)
    expect(current_path).to eq(edit_profile_path), 'プロフィール編集ページに遷移していません'
    fill_in 'ニックネーム', with: ''
    click_button '更新'
    expect(page).to have_content('ユーザー情報の更新に失敗しました'), 'フラッシュメッセージ「ユーザー情報の更新に失敗しました」が表示されていません'
    expect(page).to have_content('ユーザー名を入力してください'), 'エラーメッセージ「ユーザー名を入力してください」が表示されていません'
  end
end
