class PinsController < ApplicationController

  def edit
    @post = Post.find(params[:post_id])
    @pin = @post.pins.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @pin = @post.pins.find(params[:id])
    if @pin.update(pin_params)
      redirect_to edit_post_path(@post), notice: 'ピンを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @post = @pin.post
    @pin.destroy
    redirect_to edit_post_path(@post), notice: 'ピンを削除しました', status: :see_other
  end

  private

  def pin_params
    params.require(:pin).permit(:name, :address, :latitude, :longitude, :body, :image)
  end
end
