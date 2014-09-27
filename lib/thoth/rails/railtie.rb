require 'thoth/rails/controller_context'
require 'thoth/rails/model'

module Thoth
  class Railtie < ::Rails::Railtie
    initializer "thoth.configure_rails_initialization" do
      Thoth.logger ||= (
        file = File.open(::Rails.root.join(*%W[log events_#{ENV['RAILS_ENV']}.log]), 'a')
        file.sync = true
        Logger.new(Output::Json.new(file))
      )
    end
  end
end