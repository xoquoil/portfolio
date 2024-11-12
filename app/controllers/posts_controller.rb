class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show mapheader]
  before_action :set_post, only: %i[mapheader show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def index
    @posts = @q.result.order(created_at: :desc)
    @post = Post.order(created_at: :desc).first
    @pins = @post.pins
  end

  def myposts
    @myposts = current_user.posts.order(created_at: :desc)
    @likeposts = current_user.like_posts.includes(:user).order(created_at: :desc)
    @mypost = @myposts.first
    @likepost = @likeposts.first
    @post = @mypost
    @pins = @post.pins
  end

  def mapheader
    @pins = @post.pins
    respond_to do |format|
      format.js { render 'posts/mapheader' }
    end
  end

  def new
    @post = Post.new
    @post.pins.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: '投稿しました。'
    else
      render :new
    end
  end

  def show
    @posts = Post.order(created_at: :desc)
    @pins = @post.pins
  end

  def edit
    @pins = @post.pins
  end

  def update
    @pins = @post.pins
    if @post.update(post_params)
      redirect_to edit_post_path, notice: '投稿を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました', status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    unless @post.user == current_user
      redirect_to posts_path, alert: '権限がありません。'
    end
  end

  def post_params
    params.require(:post).permit(:name, pins_attributes: [:id, :name, :address, :latitude, :longitude, :body, :image, :_destroy])
  end
end
