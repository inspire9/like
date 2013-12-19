class Like::API < Grape::API
  format :json

  helpers do
    def interaction
      @interaction = Like.interaction_class.new self
    end
  end

  before do
    interaction.pre_action
  end

  post do
    interaction.create
    interaction.post_action
  end

  delete do
    interaction.destroy
    interaction.post_action
  end
end
