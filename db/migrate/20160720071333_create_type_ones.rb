class CreateTypeOnes < ActiveRecord::Migration
  def change
    create_table :type_ones do |t|
      t.string :name
      t.string :description
      t.string :photourl
      t.string :tag

      t.timestamps null: false
    end
  end
end
