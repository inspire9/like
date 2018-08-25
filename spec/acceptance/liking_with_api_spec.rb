require 'spec_helper'

RSpec.describe 'Liking an object', :type => :request do
  let(:user)    { User.create! email: 'pat@test.com', password: 'password',
    password_confirmation: 'password' }
  let(:article) { Article.create! }

  before :each do
    user

    Like.interaction_class = Class.new(Like::Interaction) do
      def post_action
        {'status' => 'OK'}
      end

      private

      def liker
        User.first
      end
    end
  end

  it "saves the like" do
    post '/api/likes', :params => {
      likeable_type: 'Article', likeable_id: article.id
    }

    likes = Like::Like.where(
      liker_type:    'User',    liker_id:    user.id,
      likeable_type: 'Article', likeable_id: article.id
    )

    expect(likes.count).to eq(1)
  end

  it "can delete the like" do
    post   '/api/likes', :params => {
      likeable_type: 'Article', likeable_id: article.id
    }
    delete '/api/likes', :params => {
      likeable_type: 'Article', likeable_id: article.id
    }

    likes = Like::Like.where(
      liker_type:    'User',    liker_id:    user.id,
      likeable_type: 'Article', likeable_id: article.id
    )

    expect(likes.count).to eq(0)
  end
end
