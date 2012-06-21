class Cart < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy
	accepts_nested_attributes_for :line_items
	def add_book(book_id)
		current_item = line_items.where(:book_id => book_id).first
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(:book_id => book_id)
		end
		current_item
	end

	def total_price
		line_items.to_a.sum{|item| item.total_price}
	end
end
