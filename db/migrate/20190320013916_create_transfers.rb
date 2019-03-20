class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.integer :source_account_id, foreign_key: true
      t.integer :destination_account_id, foreign_key: true
      t.column     :amount, :bigint, default: 0

      t.timestamps
    end

    add_index :transfers, :source_account_id
    add_index :transfers, :destination_account_id
  end
end
