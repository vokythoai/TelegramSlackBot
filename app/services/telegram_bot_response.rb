class TelegramBotResponse
  def initialize
    token = Rails.application.secrets.telegram[:bot][:token]
    username = Rails.application.secrets.telegram[:bot][:username]
    @bot = Telegram::Bot::Client.new(token, username)
  end


  def remove_user_from_chat message
    user_name = [message["from"]["first_name"], message["from"]["last_name"]].join(" ")
    kick_params = {chat_id: message["chat"]["id"], user_id: message["from"]["id"], until_date: (Time.zone.now + 1.minutes).to_time.to_i}
    reply_params = {chat_id: message["chat"]["id"], reply_to_message_id: message["message_id"], text: "User #{user_name} banned for 1 minutes"}
    @bot.request(:kickChatMember, kick_params)
    @bot.request(:sendMessage, reply_params)
  end

  def delete_and_send_warning_message message
    reply_params = {chat_id: message["chat"]["id"], reply_to_message_id: message["message_id"], text: "Please do not discuss about XXX here"}
    @bot.request(:sendMessage, reply_params)
  end

end