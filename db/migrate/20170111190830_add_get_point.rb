class AddGetPoint < ActiveRecord::Migration
  def change
  	add_column :shoppingcarts, :get_point, :integer
  	add_column :orders, :get_point, :integer
  end
end
