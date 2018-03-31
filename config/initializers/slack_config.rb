require 'slack-ruby-client'

Slack.configure do |config|
  config.token = "xoxp-340202531047-339985485190-338957110388-2dcfce175d6ceafab30cf6030fd901d2"
end

Slack::RealTime.configure do |config|
  config.concurrency = Slack::RealTime::Concurrency::Eventmachine
end

Slack::RealTime::Client.configure do |config|
  config.websocket_ping = 42
  config.start_method = :rtm_start
end

