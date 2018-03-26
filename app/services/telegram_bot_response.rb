class TelegramBotResponse
  def initialize
    token = Rails.application.secrets.telegram[:bot][:token]
    username = Rails.application.secrets.telegram[:bot][:username]
    @bot = Telegram::Bot::Client.new(token, username)
  end

  def remove_user_from_chat message, bot_response
    user = User.find_or_initialize_by(user_uid: message["from"]["id"])

    user.user_uid = message["from"]["id"]
    user.name = [message["from"]["first_name"], message["from"]["last_name"]].join(" ")
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
      kick_params = {chat_id: message["chat"]["id"], user_id: user.user_uid, until_date: (Time.zone.now + ban_time.minutes).to_time.to_i}
      reply_params = {chat_id: message["chat"]["id"], reply_to_message_id: message["message_id"], text: "User #{user.name} banned for #{ban_time} minutes"}
      @bot.request(:sendMessage, reply_params)
      @bot.request(:kickChatMember, kick_params)
    elsif user.number_violation < max_attempt
      reply_params = {chat_id: message["chat"]["id"], reply_to_message_id: message["message_id"], text: response_text}
      @bot.request(:sendMessage, reply_params)
    end
  end

  def remind_and_send_warning_message message, bot_response
    response_text = bot_response.message
    reply_params = {chat_id: message["chat"]["id"], reply_to_message_id: message["message_id"], text: response_text}
    @bot.request(:sendMessage, reply_params)
  end

  def delete_message message, bot_response
    delete_params = {chat_id: message["chat"]["id"], message_id: message["message_id"]}
    @bot.request(:deleteMessage, delete_params)
    reply_params = {chat_id: message["chat"]["id"], text: response_text}
    @bot.request(:sendMessage, reply_params)
  end
end