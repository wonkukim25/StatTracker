class League < ActiveRecord::Base
    attr_accessible :name, :active
	
	has_many :divisions
	
	def abbrev
		string = name.split(" ")
		puts string
		abbrev = ""
		string.each { |s|
			new = s.split(//)
			abbrev = abbrev + new[0]
		}
		abbrev
	end
	
end
