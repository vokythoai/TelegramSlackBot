class BotProcessService

  def initialize service
    @service = service.constantize
  end

  def check_scammer message, client = nil
    BotResponse.remind.pluck(:key_word).each do |key_word|
      bot_response = BotResponse.where(key_word: key_word).first
      key_word.split(",").each do |word|
        if (message["text"].gsub(/\s+/, '').downcase =~ /#{word.gsub(/\s+/, '').downcase}/) || (message["text"].gsub(/\s+/, '') =~ (Regexp.new(word))).present?
          @service.new.remind_and_send_warning_message(message, bot_response, client)
        end
      end
    end

    BotResponse.ban.pluck(:key_word).each do |key_word|
      bot_response = BotResponse.where(key_word: key_word).first
      key_word.split(",").each do |word|
        if (message["text"].gsub(/\s+/, '').downcase =~ /#{word.gsub(/\s+/, '').downcase}/) || (message["text"].gsub(/\s+/, '') =~ (Regexp.new(word))).present?
          @service.new.remove_user_from_chat(message, bot_response, client)
        end
      end
    end

    BotResponse.remove_message.pluck(:key_word).each do |key_word|
      bot_response = BotResponse.where(key_word: key_word).first
      key_word.split(",").each do |word|
        p "==============================="
        p Regexp.new(word)
        p message["text"].gsub(/\s+/, '')
        p message["text"].gsub(/\s+/, '') =~ (Regexp.new(word))
        if (message["text"].gsub(/\s+/, '').downcase =~ /#{word.gsub(/\s+/, '').downcase}/) || (message["text"].gsub(/\s+/, '') =~ (Regexp.new(word))).present?
          @service.new.delete_message(message, bot_response, client)
        end
      end
    end
    return false
  end

end