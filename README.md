# Like

A simple Rails engine for liking ActiveRecord objects.

## Installation

Add this line to your application's Gemfile:

    gem 'like', '0.2.1'

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

## Usage as an API

Like comes with an optional API you can mount instead of the standard ActionController controller. You'll need to add Grape (0.5 or newer) to your Gemfile as well, and then the API can be mounted wherever you like. There's simple POST and DELETE endpoints at the root of the API, and they accept two parameters following ActiveRecord polymorphic defaults: likeable_type and likeable_id.

```ruby
Rails.application.routes.draw do
  # mounting the following:
  mount Like::API => '/api/likes'
  # adds to endpoints:
  #   POST   /api/likes
  #   DELETE /api/likes

  # ...
end
```

You'll want to tweak the interaction class so the post_action returns something useful (instead of the default redirect, which is meaningless in the API context), and ensure the liker is set as well. Here's an example (again, it's Devise-friendly):

```ruby
Like.interaction_class = Class.new(Like::Interaction) do
  def pre_action
    error!('403 Forbidden', 403) unless liker
  end

  def post_action
    {'status' => 'OK'}
  end

  private

  def liker
    env['warden'].authenticated?(:user) ? env['warden'].user(:user) : nil
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence

Copyright (c) 2013, Like is developed and maintained by [Inspire9](http://inspire9.com), and is released under the open MIT Licence.
