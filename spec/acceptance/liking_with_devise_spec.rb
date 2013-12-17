require 'spec_helper'

describe 'Liking an object' do
  let(:user)    { User.create! email: 'pat@test.com', password: 'password',
    password_confirmation: 'password' }
  let(:article) { Article.create! }

  before :each do
    Like.controllers[:user]   = lambda { |controller| controller.current_user }
    Like.controllers[:filter] = lambda { |controller|
      controller.authenticate_user!
    }
  end

  it "saves the like if signed in" do
    visit new_user_session_path

    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password

    click_button 'Sign in'

    visit article_path(article)
    click_link 'Like'

    likes = Like::Like.where(
      liker_type:    'User',    liker_id:    user.id,
      likeable_type: 'Article', likeable_id: article.id
    )

    expect(likes.count).to eq(1)
  end

  it "redirects to the sign in page if not authenticated" do
    visit article_path(article)
    click_link 'Like'

    expect(page).to have_content('Sign in')
  end

  it "doesn't save a like if not authenticated" do
    visit article_path(article)
    click_link 'Like'

    likes = Like::Like.where(
      liker_type:    'User',    liker_id:    user.id,
      likeable_type: 'Article', likeable_id: article.id
    )

    expect(likes.count).to eq(0)
  end
end
