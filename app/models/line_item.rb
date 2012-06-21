class LineItem < ActiveRecord::Base
	belongs_to :book
	belongs_to :cart
	belongs_to :order

	validates :quantity, :presence => true, :numericality => { :only_integer => true, :greater_than => 0 }

	def total_price
		book.price*quantity
	end

end
