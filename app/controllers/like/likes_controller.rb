class Like::LikesController < ActionController::Base
  before_filter :like_filters

  def create
    Like::Like.like user, likeable

    Like.controllers[:redirect].call self
  end

  def destroy
    Like::Like.unlike user, likeable

    Like.controllers[:redirect].call self
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
