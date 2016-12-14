class TypeOne < ActiveRecord::Base
	 
	has_many :type_twos
	has_many :product_typeships, :dependent => :destroy
  	has_many :products

	scope :like, ->(args) { where("type_ones.name like '%#{args}%' OR
                                                       type_ones.description like '%#{args}%'
                                                      ")}
end
