class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_search

  def set_search
    @q = Post.ransack(params[:q])
  end

  def not_authenticated
    redirect_to login_path, notice: 'ログインしてください'
  end
end
