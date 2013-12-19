require 'spec_helper'

describe 'Liking an object' do
  let(:user)    { User.create! email: 'pat@test.com', password: 'password',
    password_confirmation: 'password' }
  let(:article) { Article.create! }

  before :each do
    Like.interaction_class = Class.new(Like::Interaction) do
      def pre_action
        controller.authenticate_user!
      end

      private

      def liker
        controller.current_user
      end
    end
  end

  context 'authenticated' do
    before :each do
      visit new_user_session_path

      fill_in 'Email',    with: user.email
      fill_in 'Password', with: user.password

      click_button 'Sign in'
    end

    it "saves the like" do
      visit article_path(article)
      click_link 'Like'

      likes = Like::Like.where(
        liker_type:    'User',    liker_id:    user.id,
        likeable_type: 'Article', likeable_id: article.id
      )

      expect(likes.count).to eq(1)
    end

    it "can delete the like" do
      visit article_path(article)
      click_link 'Like'
      click_link 'Unlike'

      likes = Like::Like.where(
        liker_type:    'User',    liker_id:    user.id,
        likeable_type: 'Article', likeable_id: article.id
      )

      expect(likes.count).to eq(0)
    end
  end

  context 'unauthenticated' do
    it "redirects to the sign in page" do
      visit article_path(article)
      click_link 'Like'

      expect(page).to have_content('Sign in')
    end

    it "doesn't save a like" do
      visit article_path(article)
      click_link 'Like'

      likes = Like::Like.where(
        liker_type:    'User',    liker_id:    user.id,
        likeable_type: 'Article', likeable_id: article.id
      )

      expect(likes.count).to eq(0)
    end
  end
end
