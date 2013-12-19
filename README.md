# Like

A simple Rails engine for liking ActiveRecord objects.

## Installation

Add this line to your application's Gemfile:

    gem 'like', '0.1.0'

Don't forget to bundle:

    $ bundle

Then, add the migrations to your app and update your database accordingly:

    $ rake like:install:migrations db:migrate

## Usage

All you need to do to use this engine is have something like the following in your views:

```erb
<% if Like::Like.liking?(current_user, article) %>
  <%= link_to 'Unlike', like_path_for(article), method: :delete %>
<% else %>
  <%= link_to 'Like', like_path_for(article), method: :post %>
<% end %>
```

And mount the necessary routes (which are already namespaced under `/like`):

```ruby
Rails.application.routes.draw do
  # ...
  mount Like::Engine => '/'
  # ...
end
```

By default, Like presumes the object that the like is created by (the liker) is available through the `current_user` method in a standard controller inheriting from ApplicationController.

If you wish to customise this, you'll need to subclass from Like::Interaction and override the `liker` method. The same goes for adding in methods to be called as part of a before filter. Here's an implementation that's Devise-friendly:

```ruby
Like.interaction_class = Class.new(Like::Interaction) do
  def pre_action
    controller.authenticate_user!
  end

  private

  def liker
    controller.current_user
  end
end
```

At some point, you'll probably want to know how many likes an object has:

```ruby
Like::Like.with_likeable(article).count
```

Or even how many likes a user has made:

```ruby
Like::Like.with_liker(user).count
```

Like doesn't care if your user model is called something else - it's a polymorphic association under the hood, so anything is accepted as the 'liker'. The same applies for 'likeable' as well.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence

Copyright (c) 2013, Like is developed and maintained by [Inspire9](http://inspire9.com), and is released under the open MIT Licence.
