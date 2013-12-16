require 'spec_helper'

describe 'Liking an object' do
  let(:user)    { User.create! }
  let(:article) { Article.create! }

  it "saves the like" do
    Like.link user, article

    likes = Like::Like.where(
      liker_type:    'User',    liker_id:    user.id,
      likeable_type: 'Article', likeable_id: article.id
    )

    expect(likes.count).to eq(1)
  end
end
