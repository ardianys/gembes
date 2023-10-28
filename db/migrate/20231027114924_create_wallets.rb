class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.integer :who_id
      t.string :who_class
      t.string :code
      t.string :name

      t.timestamps
    end
    add_index :wallets, :who_id
    add_index :wallets, :who_class
    add_index :wallets, :code
  end
end
