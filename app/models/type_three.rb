class TypeThree < ActiveRecord::Base
	belongs_to :type_two, foreign_key: "type_two_id"
end
