class CreateProductOptions < ActiveRecord::Migration
  def change
    create_table :product_options do |t|
      t.string :product_id
      t.string :option1
      t.string :option2
      t.string :option3
      t.integer :price
      t.integer :surplus
      t.timestamps null: false
    end
  end
end
