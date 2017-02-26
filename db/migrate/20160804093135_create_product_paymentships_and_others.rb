class CreateProductPaymentshipsAndOthers < ActiveRecord::Migration
  def change
    create_table :product_paymentships do |t|
      t.integer :product_id
      t.integer :payment_id
	  
      t.timestamps null: false
    end
    create_table :product_deliveryships do |t|
      t.integer :product_id
      t.integer :delivery_id
	  
      t.timestamps null: false
    end
    create_table :product_typeships do |t|
      t.integer :product_id
      t.integer :type_one_id
	  
      t.timestamps null: false
    end
    add_index  :product_paymentships, [:product_id, :payment_id],  unique: true
    add_index  :product_deliveryships, [:product_id, :delivery_id],  unique: true
    add_index  :product_typeships, [:product_id, :type_one_id],  unique: true
  end
end
