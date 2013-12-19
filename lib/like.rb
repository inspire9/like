require 'rails'

module Like
  def self.controllers
    @controllers ||= {
      user:     lambda { |controller| controller.current_user },
      filter:   lambda { |controller| true },
      redirect: lambda { |controller| controller.redirect_to :back }
    }
  end
end

require 'like/engine'
