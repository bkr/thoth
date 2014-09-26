# Thoth

Easy event logging for Rails.


## Installation

Add this line to your application's Gemfile:

    gem 'thoth'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thoth

## Usage


### Basics

The default `Thoth.logger` will write to `log/events_#{Rails.env}.log` and include `time`.  It will also populate `context` with the current `params` and `current_user.id` if `current_user` is defined.

```ruby
Thoth.logger.log(:ship_notice, previous_state: :processing, next_state: :shipped)
# {"event":"ship_notice","time":"25/Sep/2014:01:02:25 +0000","context":{"controller":"shipments","action":"create","current_user":1},"details":{state:'shipped'}}

Thoth.logger.log(:ship_notice, {context: { source: :api }}, state: :shipped)
# {"event":"ship_notice","time":"25/Sep/2014:01:02:25 +0000","context":{"controller":"shipments","action":"create","current_user":1,source:'api'},"details":{state:'shipped'}}
```

### Logging changes to a model

Include `Thoth::Rails::Model` on your model and declare `log_events`.

```ruby
class Cat < ActiveRecord::Base
  include Thoth::Rails::Model

  # :on (default [:create, :update, :destroy]) - which events should be logged
  # :only (default all attributes) - for updates, only log when these attributes are changed
  log_events on: [:update, :destroy], only: [:mood, :name]
end
```

### Changing default context

If you'd like to change what is included in the context in requests, you can overwrite the `thoth_request_context` method in your controllers.

```ruby
class ApplicationController

  def thoth_request_context
    super.merge(customer: current_customer.id)
  end
end
```

### Changing the default logger

```ruby
# create a initializers/thoth.rb file
file = File.open(Rails.root.join(*%w[log checkout_events.log]), 'a')
Thoth.logger = Thoth::Logger.new(Thoth::Output::Json.new(file))
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/thoth/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
