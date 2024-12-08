require 'rails_helper'

RSpec.describe '投稿', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:like) { create(:like, user: another_user, post:post) }

  describe '投稿のCRUD' do
    describe '投稿の一覧' do
      context 'ログインしている場合' do

        it '正しいタイトルが表示されていること' do
          login_as(user)
          expect(page).to have_title("投稿一覧 | PinPoint"), '投稿一覧ページのタイトルに「投稿一覧 | PinPoint」が含まれていません。'
        end

        context '投稿が一件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            login_as(user)
            expect(page).to have_content('投稿がありません'), '投稿が一件もない場合、「投稿がありません」というメッセージが表示されていません'
          end
        end

        context '投稿がある場合' do
          it '投稿の一覧が表示されること' do
            post
            login_as(user)
            expect(page).to have_content(post.name), '投稿一覧画面に投稿のタイトルが表示されていません'
            expect(page).to have_content(post.user.name), '投稿一覧画面に投稿者の名前が表示されていません'
          end
        end
      end
    end
    describe '投稿の詳細' do

      context 'ログインしている場合' do
        before do
          post
          login_as(user)
        end
        it '投稿の詳細が表示されること' do
          within "#js-mapheader" do
            page.find_link(post.name, exact_text: true).click
          end
          Capybara.assert_current_path("/posts/#{post.id}", ignore_query: true)
          expect(current_path).to eq("/posts/#{post.id}"), '投稿のタイトルリンクから投稿詳細画面へ遷移できません'
          expect(page).to have_content post.name
          expect(page).to have_content post.user.name
        end
        it '正しいタイトルが表示されていること' do
          within "#js-mapheader" do
            page.find_link(post.name, exact_text: true).click
          end
          expect(page).to have_title("#{post.name} | PinPoint"), '投稿詳細ページのタイトルに投稿のタイトルが含まれていません。'
        end
      end
    end
    describe '投稿の作成' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit '/posts/new'
          Capybara.assert_current_path("/login", ignore_query: true)
          expect(current_path).to eq('/login'), 'ログインしていない場合、投稿作成画面にアクセスした際に、ログインページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login_as(user)
          click_on('投稿する')
        end

        it '正しいタイトルが表示されていること' do
          expect(page).to have_title("新規MAP | PinPoint"), '投稿新規作成ページのタイトルに「新規MAP | PinPoint」が含まれていません。'
        end

        it '投稿が作成できること' do
          fill_in 'タイトル', with: 'テストタイトル'
          click_button '投稿'
          expect(page).to have_content('投稿しました'), 'フラッシュメッセージ「投稿しました」が表示されていません'
          expect(page).to have_content('テストタイトル'), '作成した投稿のタイトルが表示されていません'
        end

        it '投稿の作成に失敗すること' do
          fill_in 'タイトル', with: ''
          click_button '投稿'
          expect(page).to have_content('投稿に失敗しました'), 'フラッシュメッセージ「投稿に失敗しました」が表示されていません'
          expect(page).to have_content('Nameを入力してください'), 'エラーメッセージ「Nameを入力してください」が表示されていません'
        end
      end
    end

    describe '投稿の更新' do
      before { post }
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit edit_post_path(post)
          expect(current_path).to eq('/login'), 'ログインページにリダイレクトされていません'
          expect(page).to have_content 'ログインしてください'
        end
      end

      context 'ログインしている場合' do
        context '自分の投稿' do
          before do
            login_as(user)
            visit posts_path
            find("#js-map-for-post-#{post.id}").click
          end
          it '投稿が更新できること' do
            fill_in 'タイトル', with: '編集後テストタイトル'
            click_button '投稿'
            Capybara.assert_current_path("/posts/#{post.id}/edit", ignore_query: true)
            expect(current_path).to eq edit_post_path(post)
            expect(page).to have_content('投稿を更新しました'), 'フラッシュメッセージ「投稿を更新しました」が表示されていません'
            visit post_path(post)
            expect(page).to have_content('編集後テストタイトル'), '更新後のタイトルが表示されていません'
          end

          it '投稿の作成に失敗すること' do
            fill_in 'タイトル', with: ''
            click_button '投稿'
            expect(page).to have_content('投稿の更新に失敗しました'), 'フラッシュメッセージ「投稿の更新に失敗しました」が表示されていません'
          end
        end

        context '他人の投稿' do
          it '編集ボタンが表示されないこと' do
            login_as(another_user)
            visit posts_path
            expect(page).not_to have_selector("#button-edit-#{post.id}"), '他人の投稿に対して編集ボタンが表示されています'
          end
        end
      end
    end

    describe '投稿の削除' do
      before { post }
      context '自分の投稿' do
        it '投稿が削除できること' do
          login_as(user)
          visit '/posts'
          find("#button-delete-#{post.id}").click
          expect(current_path).to eq('/posts'), '投稿削除後に、投稿の一覧ページに遷移していません'
          expect(page).to have_content('投稿を削除しました'), 'フラッシュメッセージ「投稿を削除しました」が表示されていません'
        end
      end

      context '他人の投稿' do
        it '削除ボタンが表示されないこと' do
          login_as(another_user)
          visit posts_path
          expect(page).not_to have_selector("#button-delete-#{post.id}"), '他人の投稿に対して削除ボタンが表示されています'
        end
      end
    end
    describe '投稿のブックマーク一覧' do
      before { post }
      before { like }
      context '1件もブックマークしていない場合' do
        it '1件もない旨のメッセージが表示されること' do
          login_as(user)
          visit posts_path
          find('#header-profile').click
          click_on('マイページ')
          Capybara.assert_current_path("/mypage", ignore_query: true)
          expect(current_path).to eq(mypage_path), '課題で指定した形式のリンク先に遷移させてください'
          expect(page).to have_content('投稿がありません'), 'お気に入り中の投稿が一件もない場合、「投稿がありません」というメッセージが表示されていません'
        end
      end

      context 'ブックマークしている場合' do
        it 'ブックマークした投稿が表示されること' do
          login_as(another_user)
          visit posts_path
          find('#header-profile').click
          click_on('マイページ')
          Capybara.assert_current_path("/mypage", ignore_query: true)
          expect(current_path).to eq(mypage_path), '課題で指定した形式のリンク先に遷移させてください'
          click_on('お気に入り')
          expect(page).to have_content post.name
        end
      end
    end
  end
end
