class PinsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def edit
    @pin = @post.pins.find(params[:id])
    @pins = @post.pins
  end

  def update
    @pin = @post.pins.find(params[:id])
    if @pin.update(pin_params)
      redirect_to edit_post_path(@post), success: 'ピンを更新しました'
    else
      flash.now[:danger] = 'ピンの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy
    redirect_to edit_post_path(@post), success: 'ピンを削除しました', status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def authorize_user
    unless @post.user == current_user
      redirect_to posts_path, danger: '権限がありません。'
    end
  end

  def pin_params
    params.require(:pin).permit(:name, :address, :latitude, :longitude, :body, :image)
  end
end
