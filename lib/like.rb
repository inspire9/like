require 'rails'

module Like
  def self.controllers
    @controllers ||= {
      user:   lambda { |controller| controller.current_user },
      filter: lambda { |controller| true }
    }
  end
end

require 'like/engine'
