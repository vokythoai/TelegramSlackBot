class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :bot_response_id
      t.integer :user_uid
      t.integer :status
      t.string :name
      t.integer :number_violation
      t.timestamps
    end
  end
end
