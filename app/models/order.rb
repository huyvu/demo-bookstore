class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	validates :first_name, :last_name, :address, :phone, :email, :presence => true
	validates :first_name, :last_name, length: { maximum: 30 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_PHONE_REGEX = /^0\d+/
  	validates :email, format: { with: VALID_EMAIL_REGEX }
    validates :phone, format: { with: VALID_PHONE_REGEX },length: { minimum: 10 }

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
	end

	def total_price
		line_items.to_a.sum{|item| item.total_price}
	end
end

