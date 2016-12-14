class CreateTypeThrees < ActiveRecord::Migration
  def change
    create_table :type_threes do |t|
      t.string :name
      t.string :description
      t.string :photourl
      t.string :tag
      t.string :type_two_id

      t.timestamps null: false
    end
  end
end
