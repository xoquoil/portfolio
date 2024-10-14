class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.pins.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿しました。'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, pins_attributes: [:id, :name, :address, :latitude, :longitude, :body, :_destroy])
  end
end
