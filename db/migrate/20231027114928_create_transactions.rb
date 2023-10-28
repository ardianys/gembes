class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :from_wallet_id
      t.integer :to_wallet_id
      t.integer :from_who_id
      t.integer :to_who_id
      t.string :from_who_class
      t.string :to_who_class
      t.integer :amount

      t.timestamps
    end
  end
end
