module Like::LikesHelper
  def like_path_for(likeable)
    like.like_likes_path likeable_to_params(likeable)
  end

  def like_url_for(likeable)
    like.like_likes_url likeable_to_params(likeable)
  end

  def likeable_to_params(likeable)
    {likeable_type: likeable.class.name, likeable_id: likeable.id}
  end
end
