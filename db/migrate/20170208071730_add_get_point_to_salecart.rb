class AddGetPointToSalecart < ActiveRecord::Migration
  def change
  	add_column :salecarts, :get_point, :integer
  	add_column :salecart_products, :get_point, :integer
  end
end
