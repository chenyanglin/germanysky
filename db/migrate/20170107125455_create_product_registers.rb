class CreateProductRegisters < ActiveRecord::Migration
  def change
    create_table :product_registers do |t|
      t.string :email , :unique => true
      t.string :account_id
      t.string :account_name
      t.string :product_id
      t.string :product_option_id
      t.integer :quantity
      t.integer :sendemail
      t.timestamps null: false
    end
  end
end
