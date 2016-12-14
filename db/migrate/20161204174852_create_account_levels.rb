class CreateAccountLevels < ActiveRecord::Migration
  def change
    create_table :account_levels do |t|
      t.string :level_name
      t.integer :score
      t.integer :order_price
      t.integer :discount
      t.timestamps null: false
    end
  end
end
