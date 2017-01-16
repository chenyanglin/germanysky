class ProductRegister < ActiveRecord::Base
	belongs_to :account, foreign_key: "account_id"
	belongs_to :product_option, foreign_key: "product_option_id"
end
