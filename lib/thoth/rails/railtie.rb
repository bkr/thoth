require 'thoth/rails/controller_context'

module Thoth
  class Railtie < ::Rails::Railtie
    initializer "thoth.configure_rails_initialization" do
      Thoth.logger ||= Logger.new(Output::Json.new(File.open(::Rails.root.join(*%w[log events.log]), 'a')))
    end
  end
end