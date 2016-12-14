class Product < ActiveRecord::Base

    has_many :product_paymentships, :dependent => :destroy
    has_many :payments, :through => :product_paymentships
    has_many :product_deliveryships, :dependent => :destroy
    has_many :deliveries, :through => :product_deliveryships
    has_many :productimages
    has_many :product_typeships, :dependent => :destroy
    has_many :product_options, :dependent => :destroy
    has_one :brand
    belongs_to :type_one,  foreign_key: "type_one_id"
    belongs_to :producttype, foreign_key: "producttype_id"

	scope :like, ->(args) { where("products.name like '%#{args}%' OR
														products.id like '%#{args}%' OR
                                                       products.briefdescription like '%#{args}%'
                                                      ")}
end
