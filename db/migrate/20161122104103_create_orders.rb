class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :account_id
      t.string :account_name
      t.integer :total_price
      t.string :delivery_id
      t.string :delivery
      t.integer :delivery_price
      t.integer :cash_on_delivery
      t.string :payment_id
      t.string :payment
      t.string :receiver_name
      t.string :receiver_address
      t.string :receiver_phone
      t.integer :pay_status, :default => 1
      t.integer :delivery_status, :default => 1
      t.string :note
      t.string :use_point
      t.string :lastfivepay
      t.date :pay_date
      t.date :send_date
      t.date :change_date
      t.timestamps null: false
    end

    create_table :order_products do |t|
      t.string :order_id
      t.string :product_id
      t.string :product_name
      t.integer :single_price
      t.integer :sum_price
      t.integer :sum
      t.string :option_name
      t.timestamps null: false
    end
    create_table :order_messages do |t|
      t.string :order_id
      t.string :account_id
      t.string :content
      t.timestamps null: false
    end

  end
end
