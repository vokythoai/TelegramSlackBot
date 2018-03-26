class CreateConfig < ActiveRecord::Migration[5.1]
  def change
    create_table :configs do |t|
      t.string :config_type
      t.integer :value
    end
  end
end
