class DeleteColumnBotResponse < ActiveRecord::Migration[5.1]
  def change
    remove_column :bot_responses, :max_attempts
  end
end
