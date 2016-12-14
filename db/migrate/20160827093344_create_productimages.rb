class CreateProductimages < ActiveRecord::Migration
  def change
    create_table :productimages do |t|
  	  t.string :name
      t.attachment :upload
      t.timestamps null: false
    end
  end
end
