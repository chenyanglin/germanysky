class CreateBrandimages < ActiveRecord::Migration
  def change
    create_table :brandimages do |t|
      t.string :name
      t.string :phourl
      t.string :brand_id
      t.attachment :upload
      t.timestamps null: false
    end
  end
end
