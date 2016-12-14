class ProductDeliveryship < ActiveRecord::Base
belongs_to :product, foreign_key: "product_id"
belongs_to :delivery, foreign_key: "delivery_id"
end