class CreateTypeTwos < ActiveRecord::Migration
  def change
    create_table :type_twos do |t|
      t.string :name
      t.string :description
      t.string :photourl
      t.string :tag
      t.string :tier_one_id

      t.timestamps null: false
    end
  end
end
