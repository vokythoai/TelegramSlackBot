class TelegramBotProcessService
  class << self
    def check_scammer message
      BotResponse.remind.pluck(:key_word).each do |key_word|
        key_word.split(",").each do |word|
          if message["text"].gsub(/\s+/, '') =~ /#{word}/
            bot_response = BotResponse.where(key_word: word).first
            TelegramBotResponse.new.remind_and_send_warning_message(message, bot_response)
          end
        end
      end

      BotResponse.ban.pluck(:key_word).each do |key_word|
        key_word.split(",").each do |word|
          if message["text"].gsub(/\s+/, '') =~ /#{word}/
            bot_response = BotResponse.where(key_word: word).first
            TelegramBotResponse.new.remove_user_from_chat(message, bot_response)
          end
        end
      end

      BotResponse.remove_message.pluck(:key_word).each do |key_word|
        key_word.split(",").each do |word|
          if message["text"].gsub(/\s+/, '') =~ /#{word}/
            bot_response = BotResponse.where(key_word: word).first
            TelegramBotResponse.new.delete_message(message, bot_response)
          end
        end
      end
      return false
    end
  end
end