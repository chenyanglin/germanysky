class ProductSpecialoffership < ActiveRecord::Base
belongs_to :product, foreign_key: "product_id"
belongs_to :product_option, foreign_key: "product_option_id"
belongs_to :specialoffer, foreign_key: "specialoffer_id"
end
