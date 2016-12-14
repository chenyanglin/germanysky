class CreateUserlevels < ActiveRecord::Migration
  def change
    create_table :userlevels do |t|
      t.string :level_name
      t.integer :point_min
      t.integer :point_max
      t.integer :discountrate
      t.integer :level
      t.timestamps null: false
    end
  end
end
