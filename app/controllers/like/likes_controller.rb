class Like::LikesController < ApplicationController
  if ActionPack::VERSION::STRING.to_i > 4
    before_action { interaction.pre_action }
  else
    before_filter { interaction.pre_action }
  end

  def create
    interaction.create
    interaction.post_action
  end

  def destroy
    interaction.destroy
    interaction.post_action
  end

  private

  def interaction
    @interaction ||= Like.interaction_class.new self
  end
end
