class CreateProductMessages < ActiveRecord::Migration
  def change
    create_table :product_messages do |t|
      t.string :account_id
      t.string :account_name
      t.string :product_id
      t.string :content
      t.string :reply
      t.integer :status, :default => 0
      t.timestamps null: false
    end
  end
end
