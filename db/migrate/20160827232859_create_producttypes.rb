class CreateProducttypes < ActiveRecord::Migration
  def change
    create_table :producttypes do |t|

      t.string :name
    end
  end
end
