# This file is used by Rack-based servers to start the application.
require_relative 'config/environment'
require ::File.expand_path('../config/environment', __FILE__)
require ::File.expand_path('../slack_bot/slack_bot', __FILE__)

Thread.abort_on_exception = true
Thread.new do
  SlackBot.run
end


run Rails.application
