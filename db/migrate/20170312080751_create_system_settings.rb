class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.integer :free_shipping_switch
      t.integer :free_shipping_limit 
      t.integer :point_switch
      t.string :notice, :limit => 5000
      t.timestamps null: false
    end
  end
end
