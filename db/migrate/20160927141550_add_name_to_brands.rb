class AddNameToBrands < ActiveRecord::Migration
  def change
  	add_column :brands, :name, :string
  	add_column :brands, :briefdescription, :string
  	add_column :brands, :detaildescription, :string
  end
end
