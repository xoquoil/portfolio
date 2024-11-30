class StaticPagesController < ApplicationController
  skip_before_action :require_login
  
  def privacy_policy; end

  def terms_of_use; end

  def how_to_use; end
end
