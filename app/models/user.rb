class User < ActiveRecord::Base
  belongs_to :bot_response

  enum status: %w(ban unban remind active)
end