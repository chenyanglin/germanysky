class CreateProduct < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.string :title
      t.string :name
      t.string :briefdescription
      t.string :detaildescription
      t.integer :price
      t.integer :surplus
      t.string :phourl
      t.boolean :on_store
      t.boolean :available
      t.string :type_one_id
      t.string :type_two_id
      t.string :type_three_id
      t.string :producttype_id #現貨 1 預購空運2 預購海運3
      t.string :brand_id
      t.integer :point, :default => 0
      t.timestamps null: false

    end
  end
end
