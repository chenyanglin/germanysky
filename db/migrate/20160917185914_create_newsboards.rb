class CreateNewsboards < ActiveRecord::Migration
  def change
    create_table :newsboards do |t|
      t.string :title
      t.string :subtitle
      t.string :content
      t.timestamps null: false
    end
  end
end
