require 'bundler/setup'
Bundler.setup

ENV["RAILS_ENV"] ||= 'test'
require 'thoth'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'pry-remote'
require 'timecop'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end