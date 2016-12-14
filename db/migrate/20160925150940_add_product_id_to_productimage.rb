class AddProductIdToProductimage < ActiveRecord::Migration
  def change
    add_column :productimages, :product_id, :string
  end
end
