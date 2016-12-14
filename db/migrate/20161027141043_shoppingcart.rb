class Shoppingcart < ActiveRecord::Migration
  def change
  	create_table :shoppingcarts do |t|
  	  t.string :account_id
      t.string :product_id
      t.string :option_id
      t.integer :sum
      t.integer :originalprice
      t.integer :sellprice
      t.timestamps null: false
  	end
  end
end
