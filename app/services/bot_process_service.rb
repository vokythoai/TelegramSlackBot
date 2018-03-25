class BotProcessService
  class << self
    def check_scammer message
      BLACK_LIST_WORD[:remind].each do |word|
        if message["text"] =~ /#{word}/
          TelegramBotResponse.new.delete_and_send_warning_message(message)
        end
      end

      BLACK_LIST_WORD[:ban].each do |word|
        if message["text"] =~ /#{word}/
          TelegramBotResponse.new.remove_user_from_chat(message)
        end
      end
      return false
    end
  end
end