require 'slack-ruby-client'

class SlackBot < SlackRubyBot::Bot
  match /./ do |client, data, match|
    bot = BotProcessService.new("SlackBotResponse")
    bot.check_scammer(data, client)
  end
end