class CreateOfferImages < ActiveRecord::Migration
  def change
    create_table :offer_images do |t|
      t.string :specialoffer_id
      t.string :phourl
  	  t.string :name
      t.attachment :upload
      t.timestamps null: false
    end
  end
end
