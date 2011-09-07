class Team < ActiveRecord::Base
    attr_accessible :franchise_id, :division_id, :year, :baseball_era, :name, :park, :attendance, :rank, :games, :home_games, :wins, :losses, :div_win, :wc_win, :lg_win, :ws_win, :runs, :plate_appearances, :at_bats, :hits, :doubles, :triples, :home_runs, :total_bases, :extra_base_hits, :walks, :strikeouts, :stolen_bases, :caught_stealing, :hit_by_pitch, :sacrifice_flies, :runs_allowed, :earned_runs, :complete_games, :shutouts, :saves, :innings_pitched_outs, :hits_allowed, :home_runs_allowed, :walks_allowed, :strikeouts_allowed, :errors_made, :double_plays, :fielding_percentage, :batters_park_factor, :pitchers_park_factor

	has_many :batting_stats
	has_many :batting_post_stats
	has_many :pitching_stats
	has_many :pitching_post_stats
	has_many :fielding_stats
	has_many :fielding_post_stats
	belongs_to :division
	belongs_to :franchise

  def pct
	sprintf("%.3f", wins.quo(wins+losses).to_f.round(3))
  end
  
  # Search all teams that have a name or park like some term
  def self.search(search)
    search_condition = "%" + search.downcase + "%"
    find(:all, :conditions => ['lower(name) LIKE ? OR lower(park) LIKE ?', search_condition, search_condition])
  end

  def self.season_compare(comp)
		split_strings = comp.split("/")
		teams = []
		split_strings.each { |s|
			split = s.split(".")
			team = split[0]
			year = split[1]
			teams.push(Team.find(:all, :conditions => ['franchise_id = ? AND year = ?', s.to_i, year]))
		}
		teams
	end
	
	def self.career_compare(comp)
		split_strings = comp.split("/")
		franchises = {}
		split_strings.each { |s|
			stats = Team.find(:all, :conditions => ['franchise_id = ?', s.to_i])
			stats.each { |st|
				franchises.store(st, s.to_i)
			}
		}
		franchises
	end
	
	def self.multi_compare(comp)
		split_strings = comp.split("/")
		franchises = {}
		max = 0
		years_array = []
		split_strings.each { |s|
			split_franchise = s.split(".")
			franchise = split_franchise[0]
			years = split_franchise[1]
			split_years = years.split(":")
			year1 = split_years[0]
			year2 = split_years[1]
			newmax = year2.to_i - year1.to_i + 1
			if newmax > max
				max = newmax
			end	
			stats = Team.find(:all, :conditions => ['franchise_id = ? AND year >= ? AND year <= ?', s.to_i, year1, year2])
			stats.each { |st|
				franchises.store(st, s.to_i)
			}
			years_array.push(year1 + ' - ' + year2)
		}
		return franchises, max, years_array
	end
	
	def self.get_all_stats(franchise, stat)
		Team.find(:all, :select => [stat], :conditions => ['franchise_id = ?', franchise])
	end
	
	def self.get_multi_stat_total(franchise, stats, stat)
		total = 0
		stats.each_pair { |key, value|	
			if value.to_i == franchise
				total += key.send(stat)
			end
		}
		total.to_s
	end
	
	def self.get_change_multi_stat_total(franchise, stats, stat)
		total = 0
		stats.each { |s|	
		t = Team.find(s)
			if t.franchise_id == franchise
				total += t.send(stat)
			end
		}
		total.to_s
	end
	
	def self.get_multi_stats(franchise, stats, stat)
		all_stats = []
		years = []
		stats.each_pair { |key, value|
			if value == franchise
				if years.index(key.year).nil?
					all_stats.push(key.send(stat))
					years.push(key.year)
				else
					all_stats[all_stats.size-1] += key.send(stat)
				end
			end
		}
		all_stats
	end
	
	def self.get_change_multi_stats(franchise, stats, stat)
		all_stats = []
		years = []
		stats.each { |s|
		t = Team.find(s)
			if t.franchise_id == franchise
				if years.index(t.year).nil?
					all_stats.push(t.send(stat))
					years.push(t.year)
				else
					all_stats[all_stats.size-1] += t.send(stat)
				end
			end
		}
		all_stats
	end
 
	def self.get_stat_total(franchise, stat)
		stats = Team.find(:all, :select => [stat], :conditions => ['franchise_id = ?', franchise])
		count = 0
		stats.each { |s|
		count += s.send(stat)
		}
		count.to_s
	end
	
end
