class Cat < ActiveRecord::Base
	has_many :books
	validates :name, :presence => true

	def to_param
		"#{id} #{name}".parameterize
	end
end
