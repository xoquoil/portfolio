class PinsController < ApplicationController

  def edit
    @pin = Pin.find(params[:id])
    @post = @pin.post
  end

  def update
    @pin = Pin.find(params[:id])
    @post = @pin.post
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
