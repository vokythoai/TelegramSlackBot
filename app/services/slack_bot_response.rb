class SlackBotResponse
  def initialize
    token = "xoxp-340202531047-339985485190-338957110388-2dcfce175d6ceafab30cf6030fd901d2"
    @logger ||= (Slack::Config.logger || Slack::Logger.default)
    @admin_client = Slack::Web::Client.new(token: token, logger: @logger)
  end

  def remove_user_from_chat message, bot_response, client
    user = User.find_or_initialize_by(user_uid: message["user"])
    user.user_uid = message["user"]
    user.bot_response = bot_response
    user.save

    max_attempt = Config.where(config_type: "max_attempt").first.value.to_i
    ban_time = Config.where(config_type: "ban_time").first.value.to_i
    response_text = bot_response.message

    if user
      if user.number_violation < max_attempt
        user.number_violation += 1
        user.save
      end
    end

    if user.number_violation == max_attempt
      user.number_violation = 0
      user.save
      client.web_client.chat_postMessage channel: message.channel, text: "User <@#{message.user}> is banned for violating the rules!", as_user: true
      @admin_client.channels_kick channel: message.channel, user: message.user, as_user: true
    elsif user.number_violation < max_attempt
      client.web_client.chat_postMessage channel: message.channel, text: response_text, as_user: true
    end
  end

  def remind_and_send_warning_message message, bot_response, client
    response_text = bot_response.message
    client.web_client.chat_postMessage channel: message.channel, text: response_text, as_user: true, thread_ts: message.ts
  end

  def delete_message message, bot_response, client
    @admin_client.chat_delete channel: message.channel, text: message.text, ts: message.ts, as_user: true
  end
end