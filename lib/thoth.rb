require "thoth/version"
require 'thoth/default_logger'
require 'thoth/context'
require 'thoth/output/json'
require 'thoth/logger'
require 'thoth/rails/railtie' if defined?(Rails)

module Thoth
  extend DefaultLogger, Context
end
