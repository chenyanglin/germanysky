class CreateSpecialoffers < ActiveRecord::Migration
  def change
    create_table :specialoffers do |t|

      t.string :name
      t.string :type #價格優惠、折扣優惠
      t.integer :productcount
      t.integer :saleprice
      t.integer :discount
      t.string :phourl
      t.string :status
      t.timestamps :StartDate
      t.timestamps :EndDate
      t.timestamps null: false
    end
  end
end
