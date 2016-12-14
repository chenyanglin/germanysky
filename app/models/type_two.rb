class TypeTwo < ActiveRecord::Base
	belongs_to :type_one, foreign_key: "type_one_id"
	has_many :type_threes
end
