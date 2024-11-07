class LikesController < ApplicationController
  def create
    @post =Post.find(params[:post_id])
    current_user.like(@post)

    respond_to do |format|
      format.js { render 'likes/create' }
    end
  end

  def destroy
    @post = current_user.likes.find(params[:id]).post
    current_user.unlike(@post)

    respond_to do |format|
      format.js { render 'likes/destroy' }
    end
  end
end
