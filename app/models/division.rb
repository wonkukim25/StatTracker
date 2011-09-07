class Division < ActiveRecord::Base
    attr_accessible :name, :league_id
	
	has_many :teams
	belongs_to :league
	
end
