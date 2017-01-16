class AddReplyToOrderMessage < ActiveRecord::Migration
  def change
  	add_column :order_messages, :reply, :string
  	add_column :order_messages, :status, :integer
  	add_column :order_messages, :account_name, :string
  end
end
