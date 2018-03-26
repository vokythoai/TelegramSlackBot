class CreateBotResponseTable < ActiveRecord::Migration[5.1]
  def change
    create_table :bot_responses do |t|
      t.integer :response_type
      t.integer :max_attempts
      t.string :message
      t.string :key_word
      t.timestamps
    end
  end
end
