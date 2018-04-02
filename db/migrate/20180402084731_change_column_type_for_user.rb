class ChangeColumnTypeForUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :user_uid, :string
  end
end
