class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.string :description
      t.integer :dayline
      t.integer :price

      t.timestamps null: false
    end
  end
end
