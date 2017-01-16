class CreateProductSpecialofferships < ActiveRecord::Migration
  def change
    create_table :product_specialofferships do |t|
      t.integer :product_id
      t.integer :product_option_id
      t.integer :specialoffer_id
      t.timestamps null: false
    end
    add_index  :product_specialofferships, [:product_id, :product_option_id,:specialoffer_id],  unique: true, :name => 'offer_index'
  end
end
