class Book < ActiveRecord::Base
	belongs_to :cat
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :img_url, :author, presence: true
  	validates :price, numericality: {greater_than_or_equal_to: 1000}
# 
  	#validates :title, uniqueness: true
  	validates :img_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)$}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  	}
  	validates :title, length: {minimum: 10}

    def self.search(search)
      if search
        find(:all, :conditions => ['title LIKE ?',"%#{search}%"])
      else
        find(:all)
      end
    end

	private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
