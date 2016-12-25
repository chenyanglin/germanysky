class ProductMessage < ActiveRecord::Base
belongs_to :product, foreign_key: "product_id"
belongs_to :account, foreign_key: "account_id"
end
