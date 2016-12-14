class ProductTypeship < ActiveRecord::Base
belongs_to :product, foreign_key: "product_id"
belongs_to :type_one, foreign_key: "type_one_id"
end