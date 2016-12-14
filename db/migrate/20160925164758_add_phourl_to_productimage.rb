class AddPhourlToProductimage < ActiveRecord::Migration
  def change
    add_column :productimages, :phourl, :string
  end
end
