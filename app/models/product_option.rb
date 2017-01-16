class ProductOption < ActiveRecord::Base
belongs_to :product, foreign_key: "product_id"
has_many :product_registers
has_many :shoppingcarts
has_many :product_specialofferships, :dependent => :destroy
has_many :specialoffers, :through => :product_specialofferships
end
