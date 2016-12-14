class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.boolean :available

      t.timestamps null: false
    end
  end
end
