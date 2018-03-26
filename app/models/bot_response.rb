class BotResponse < ActiveRecord::Base
  has_many :users

  enum response_type: %w(remind ban remove_message)
end