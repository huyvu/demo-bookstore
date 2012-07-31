class Cat < ActiveRecord::Base
	has_many :books
	validates :name, :presence => true
	validates :name, :uniqueness => true

	def to_param
		"#{id} #{name}".parameterize
	end
end
