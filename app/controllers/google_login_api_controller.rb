class GoogleLoginApiController < ApplicationController
  require 'googleauth/id_tokens/verifier'
  protect_from_forgery except: :callback
  before_action :verify_g_csrf_token
  skip_before_action :require_login

  def callback
    begin
      payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '1040062858247-5l8k6qmrvca73nm46lm6hoaihc6vna9g.apps.googleusercontent.com')
      
      # ユーザー検索または作成
      user = User.find_or_create_by(email: payload['email']) do |u|
        u.name = payload['name'] || 'Unknown' # 名前が取得できない場合のデフォルト値
        u.password = SecureRandom.hex(16)    # ランダムパスワードを設定
        u.password_confirmation = u.password
      end
      
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    rescue Google::Auth::IDTokens::VerificationError => e
      Rails.logger.error "Google Token Verification Failed: #{e.message}"
      redirect_to root_path, alert: 'Googleログインに失敗しました'
    rescue StandardError => e
      Rails.logger.error "Login Error: #{e.message}"
      redirect_to root_path, alert: 'エラーが発生しました'
    end
  end

  private

  def verify_g_csrf_token
    if cookies["g_csrf_token"].blank? || params[:g_csrf_token].blank? || cookies["g_csrf_token"] != params[:g_csrf_token]
      redirect_to root_path, notice: '不正なアクセスです'
    end
  end
end
