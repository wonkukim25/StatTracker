module ApplicationHelper

	def valid_finder?(num)
		if !(num.to_i > 0)
			puts 'dfdsfdsf'
			return true
		else 
			return false
		end
	end
end
