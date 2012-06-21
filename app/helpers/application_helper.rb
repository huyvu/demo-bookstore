module ApplicationHelper
	def current_link_to label, path
  		link_to label, path, class: (current_page?(path) ? "active" : nil)
	end
end
