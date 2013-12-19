class Like::LikesController < ApplicationController
  before_filter { interaction.pre_action }

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
