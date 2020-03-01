class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :from_account, foreign_key: { to_table: :bank_accounts }
      t.references :to_account, foreign_key: { to_table: :bank_accounts }
      t.decimal :amount

      t.timestamps
    end
  end
end
