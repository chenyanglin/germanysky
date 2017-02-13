class CreateSalecarts < ActiveRecord::Migration
  def change
    create_table :salecarts do |t|
      t.string :account_id
      t.string :specialoffer_id
      t.timestamps null: false
    end
    create_table :salecart_products do |t|
      t.string :product_id
      t.string :option_id
      t.string :salecart_id
      t.integer :sum
      t.integer :originalprice
      t.integer :sellprice
      t.timestamps null: false
    end
  end
end
