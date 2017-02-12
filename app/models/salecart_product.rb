class SalecartProduct < ActiveRecord::Base
	belongs_to :salecart, foreign_key: "salecart_id"
	belongs_to :product, foreign_key: "product_id"
	belongs_to :product_option, foreign_key: "option_id"
end
