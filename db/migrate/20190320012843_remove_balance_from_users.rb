class RemoveBalanceFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :balance, :bigint, default: 0
  end
end
