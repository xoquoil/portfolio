class PostsController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
    @post.pins.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path, notice: '投稿しました。'
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
