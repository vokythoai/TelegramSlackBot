require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV["SLACK_BOT_TOKEN"]
end

Slack::RealTime.configure do |config|
  config.concurrency = Slack::RealTime::Concurrency::Eventmachine
end

Slack::RealTime::Client.configure do |config|
  config.websocket_ping = 42
  config.start_method = :rtm_start
end

