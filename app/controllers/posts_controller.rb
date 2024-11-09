class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @posts = Post.order(created_at: :desc)
    @post = Post.order(created_at: :desc).first
    @pins = @post.pins
  end

  def myposts
    @myposts = current_user.posts.order(created_at: :desc)
    @likeposts = current_user.like_posts.includes(:user)
    @mypost = @myposts.first
    @likepost = @likeposts.first
    @post = @mypost
    @pins = @post.pins
  end

  def mapheader
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    @pins = @post.pins
  end

  def edit
    @post = Post.find(params[:id])
    @pins = @post.pins
  end

  def update
    @post = Post.find(params[:id])
    @pins = @post.pins
    if @post.update(post_params)
      redirect_to edit_post_path, notice: '投稿を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました', status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:name, pins_attributes: [:id, :name, :address, :latitude, :longitude, :body, :image, :_destroy])
  end
end
