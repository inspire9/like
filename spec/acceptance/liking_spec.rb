require 'spec_helper'

describe 'Liking an object' do
  let(:user)    { User.create! email: 'pat@test.com', password: 'password',
    password_confirmation: 'password' }
  let(:article) { Article.create! }

  it "saves the like" do
    Like::Like.like user, article

    likes = Like::Like.where(
      liker_type:    'User',    liker_id:    user.id,
      likeable_type: 'Article', likeable_id: article.id
    )

    expect(likes.count).to eq(1)
  end

  it "saves the like through a web request" do
    user
    Like.interaction_class = Class.new(Like::Interaction) do
      def liker
        User.first
      end
    end

    post '/like/likes', {likeable_type: 'Article', likeable_id: article.id},
      {'HTTP_REFERER' => '/'}

    likes = Like::Like.where(
      liker_type:    'User',    liker_id:    user.id,
      likeable_type: 'Article', likeable_id: article.id
    )

    expect(likes.count).to eq(1)
  end
end
