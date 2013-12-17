class Like::LikesController < ActionController::Base
  before_filter :like_filters

  def create
    Like::Like.like user, likeable

    redirect_to :back
  end

  private

  def like_filters
    Like.controllers[:filter].call self
  end

  def likeable
    likeable = params[:likeable_type].constantize.find params[:likeable_id]
  end

  def user
    Like.controllers[:user].call self
  end
end
