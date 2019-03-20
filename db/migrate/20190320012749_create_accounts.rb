class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.column     :balance, :bigint, default: 0

      t.timestamps
    end
  end
end
