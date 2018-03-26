class AddDefaultValueForBotResponse < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :number_violation, :integer, :default => 0
  end
end
