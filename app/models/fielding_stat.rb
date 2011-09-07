class FieldingStat < ActiveRecord::Base
    attr_accessible :player_id, :team_id, :stint, :position, :games, :games_started, :inning_outs, :chances, :put_outs, :assists, :errors_made, :double_plays, :passed_balls, :wild_pitches, :stolen_bases, :caught_stealing, :zone_rating
	
	belongs_to :player
	belongs_to :team
	
	def self.single_season_sort(stat)
		s = accessible_attributes.include?(stat)? stat.to_s : send("str_" + stat)
		min_g = accessible_attributes.include?(stat)? 0 : 80
		FieldingStat.find(:all, :conditions => ["games > ?", min_g], :order => s + " DESC", :limit =>  50)
	end
	
	def self.career_sort(stat)
		if accessible_attributes.include?(stat)
			stats = FieldingStat.find(:all, :select => [:player_id, stat.to_sym, :position], :joins => [:player])
			comb = {}
			stats.each { |s| 
				if comb.has_key?(s.player_id)
						comb[s.player_id] += s.send(stat).to_i
				else
					if (s.send(stat) == 0 || s.send(stat).nil?)
						comb.store(s.player_id, 0)
					else
						comb.store(s.player_id, s.send(stat))
					end
				end
			} 
			sorted = comb.sort{|a,b| b[1] <=> a[1]}
			sorted.take(50).each { |a| 
			a[0] = Player.find(a[0])
			}
			return sorted.take(50)
		else 
			s = "str_career_" + stat
			Player.find(:all, :conditions => ["career_games > ?", 500], :order => Player.send(s), :limit => 50)
		end
	end
	
	def self.active_sort(stat)
		if accessible_attributes.include?(stat)
			stats = FieldingStat.find(:all, :select => [:player_id, stat.to_sym, :position], :conditions => ["final_game is NULL"], :joins => [:player])
			comb = {}
			stats.each { |s| 
				if comb.has_key?(s.player_id)
						comb[s.player_id] += s.send(stat).to_i
				else
					if (s.send(stat) == 0 || s.send(stat).nil?)
						comb.store(s.player_id, 0)
					else
						comb.store(s.player_id, s.send(stat))
					end
				end
			} 
			sorted = comb.sort{|a,b| b[1] <=> a[1]}
			sorted.take(50).each { |a| 
			a[0] = Player.find(a[0])
			}
			return sorted.take(50)
		else 
			s = "str_career_" + stat
			Player.find(:all, :conditions => ["career_games > ? AND final_game is NULL", 500], :order => Player.send(s), :limit => 50)
		end
	end

	def year
		team.year
	end
	
	def innings
		inning_outs / 3
	end

	def fielding_percentage
		sprintf("%.3f", ((put_outs + assists) / chances) )
	end

	def range_factor_innings
		sprintf("%.3f", rfi)
	end

	def range_factor_game
		sprintf("%.3f", rfg)
	end
	
	# def lfp(team_id, position)
		# fielders = FieldingStat.find(:all, :conditions => ["position = ? AND team.year = ?", position])
		# puts "*****"
		# po = 0
		# a = 0
		# c = 0
		# puts "****"
		# fielders.each {|f|
			# po += f.put_outs
			# puts po
			# a += f.assists
			# c += f.chances
		# }
		# puts "***"
		# puts po + a
		# puts c
		# sprintf("%.3f", ((po + a) / c.to_f))
	# end
  
	private
	
	def rfi
		(9 * (put_outs + assists) / innings.to_f)
	end
	
	def rfg
		(put_outs + assists) / games.to_f
	end
	
	def self.multiplier
		10000
	end
	
	def self.str_fielding_percentage
		"(put_outs + assists) * #{multiplier} / chances "
	end
	
	def self.str_range_factor_innings
		"(9* (put_outs + assists)) * #{multiplier} / (inning_outs / 3) "
	end
	
	def self.str_range_factor_game
		"(put_outs + assists) * #{multiplier} / games "
	end
	
	
#League Range Factor/9 Innings (lgRF9)
#League Range Factor/ Game (lgRFG)


end
