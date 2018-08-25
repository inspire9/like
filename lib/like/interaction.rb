class Like::Interaction
  def initialize(controller)
    @controller = controller
  end

  def create
    Like::Like.like liker, likeable
  end

  def destroy
    Like::Like.unlike liker, likeable
  end

  def post_action
    if ActionPack::VERSION::STRING.to_i > 4
      controller.redirect_back fallback_location: "/"#, status: 303
    else
      controller.redirect_to :back, status: 303
    end
  end

  def pre_action
    #
  end

  private

  attr_reader :controller
  delegate :params, to: :controller

  def likeable
    @likeable ||= params[:likeable_type].constantize.find params[:likeable_id]
  end

  def liker
    controller.current_user
  end
end
