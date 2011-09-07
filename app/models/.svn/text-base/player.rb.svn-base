class Player < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :name, :nickname, :birth_year, :birth_month, :birth_day, :birth_country, :birth_state, :birth_city, :death_year, :death_month, :death_day, :death_country, :death_state, :death_city, :weight, :height, :bats, :throws, :debut, :final_game, :college, :hof, :career_plate_appearances, :career_at_bats, :career_hits, :career_home_runs, :career_total_bases, :career_stolen_bases, :career_caught_stealing, :career_walks, :career_strikeouts, :career_walks, :career_hit_by_pitch, :career_sacrifice_flies, :career_plate_appearances_post, :career_at_bats_post, :career_hits_post, :career_home_runs_post, :career_total_bases_post, :career_stolen_bases_post, :career_caught_stealing_post, :career_walks_post, :career_strikeouts_post, :career_hit_by_pitch_post, :career_sacrifice_flies_post, :career_wins, :career_losses, :career_innings_pitched_outs, :career_earned_runs, :career_runs_allowed, :career_hits_allowed, :career_batters_faced, :career_walks_allowed, :career_hit_by_pitches_allowed, :career_home_runs_allowed, :career_strikeouts_allowed, :career_wins_post, :career_losses_post, :career_innings_pitched_outs_post, :career_earned_runs_post, :career_runs_allowed_post, :career_hits_allowed_post, :career_batters_faced_post, :career_walks_allowed_post, :career_hit_by_pitches_allowed_post, :career_home_runs_allowed_post, :career_strikeouts_allowed_post, :career_put_outs, :career_assists, :career_inning_outs, :career_games, :career_put_outs_post, :career_assists_post, :career_inning_outs_post, :career_games_post

    has_many :batting_stats
	has_many :batting_post_stats
	has_many :pitching_stats
	has_many :pitching_post_stats
	has_many :fielding_stats
	has_many :fielding_post_stats
	
	 if Rails.env.development?
		scope :year, lambda { |year| where("strftime('%Y', debut) == '#{year}'")}
	elsif Rails.env.production?
		scope :year, lambda { |year| where("debut_part('year', debut)::integer = #{year}") }
	else
		scope :year, lambda { |year| }
	end
	
	def birthday
		if birth_year.nil?
			return nil
		elsif birth_month.nil?
		birth_year.to_s 
		elsif birth_day.nil?
		birth_month.to_s+"\/"+birth_year.to_s
		else
		birth_month.to_s+"\/"+birth_day.to_s+"\/"+birth_year.to_s
		end
	end
	
	def age(year)
		if birth_year.nil?
			return "NA"
		elsif birth_month.nil?
			birthday = DateTime.new(y=birth_year, m = 1, d = 1)
		elsif birth_day.nil?
			birthday = DateTime.new(y=birth_year, m = birth_month, d = 1)
		else
			birthday = DateTime.new(y=birth_year, m = birth_month, d = birth_day)
		end
		season_start = DateTime.new(y=year, m = 7, d = 1, h=0, m=0, s=0)
		(season_start-birthday).to_i/365
	end
	
	def heightFeet
		(height/12).to_s+"\' "+(height%12).to_s+"\""
	end

	def birthPlace
	if birth_country.nil?
		return nil
	elsif birth_state.nil?
		return birth_city+ ", "+birth_country
  elsif birth_city.nil?
    return nil
	else
		return birth_city+ ", "+birth_state+ ", "+birth_country
	end
	end

  # search for all the players in the system by either first or last name
  def self.player_search(search)
    search_condition = "%" + search.downcase + "%"
    find(:all, :conditions => ["lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(first_name) || ' ' || lower(last_name) LIKE ?", search_condition, search_condition, search_condition], :order => "(final_game IS NOT NULL), last_name ASC, first_name ASC")
  end
  
  def auto_search
	if !debut.nil?
		if final_game.nil?
			name + ", " + debut.year.to_s + " - "
		else 
			name + ", " + debut.year.to_s + " - " + final_game.year.to_s
		end
	end
  end
  
  def filter
    @players = Player.paginate :page => params[:page], :order => 'last_name',
         :conditions=>["last_name LIKE ? or last_name LIKE ? or last_name LIKE ? last_name like ?",
         'A%', 'B%', 'C%', 'D%']
  end
  
	def self.multiplier
		10000
	end
  
	# Batting Stats
	def self.str_career_batting_average
		"career_hits * #{multiplier} / career_at_bats DESC"
	end
	
	def self.str_career_on_base_percentage
    "(career_hits + career_walks + career_hit_by_pitch) * #{multiplier} / (career_at_bats + career_walks + career_hit_by_pitch + career_sacrifice_flies) DESC"
	end

  def self.str_career_slugging_percentage
    "career_total_bases * #{multiplier} / career_at_bats DESC"
  end

  def self.str_career_on_base_plus_slugging
    "((career_hits + career_walks + career_hit_by_pitch) * #{multiplier} / (career_at_bats + career_walks + career_hit_by_pitch + career_sacrifice_flies)) + (career_total_bases * #{multiplier} / career_at_bats) DESC"
  end

  def self.str_career_stolen_base_percentage
    "career_stolen_bases * #{multiplier} / (career_stolen_bases + career_caught_stealing) DESC"
  end

  def self.str_career_at_bats_per_strikeout
    "career_at_bats * #{multiplier} / career_strikeouts DESC"
  end

  def self.str_career_at_bats_per_home_run
    "(career_at_bats * #{multiplier} / career_home_runs) ASC"
  end

  # def self.str_career_adjusted_ops
    # league_obp = BattingStat.where(year => self.year).average(on_base_percentage)
    # league_slg = BattingStat.where(year => self.year).average(slugging_percentage)
    # 100 * ((obp / league_obp) + (slg / league_slg) - 1)
  # end

  # def self.str_career_isolated_power
    # "#{str_career_slugging_percentage} - #{str_career_batting_average} DESC"
  # end

  def self.str_career_runs_created
    "((career_hits + career_walks) * career_total_bases) * #{multiplier} / (career_at_bats + career_walks) DESC"
  end

  def self.str_career_secondary_average
    "(career_total_bases - career_hits + career_walks + career_stolen_bases - career_caught_stealing) * #{multiplier} / career_at_bats DESC"
  end

  def self.str_career_base_runs
    "((career_hits + career_walks - career_home_runs) * ((1.4 * career_total_bases - 0.6 * career_hits - 3 * career_home_runs + 0.1 * career_walks) * 1.02)) * 10000/(((1.4 * career_total_bases - 0.6 * career_hits - 3 * career_home_runs + 0.1 * career_walks) * 1.02) + (career_at_bats - career_hits)) + career_home_runs * 10000 DESC"
  end
	
	def career_batting_average
		sprintf("%.3f", avg)
	end
	
	def career_on_base_percentage
		sprintf("%.3f", obp)
	end
  
	def career_slugging_percentage
		sprintf("%.3f", slg)
	end

	def career_on_base_plus_slugging
		sprintf("%.3f", ops)
	end

	def career_at_bats_per_strikeout
		sprintf("%.2f", ab_per_k)
	end

	def career_at_bats_per_home_run
		sprintf("%.2f", ab_per_hr)
	end

	def career_adjusted_ops
		league_obp = BattingStat.where(year => self.year).average(on_base_percentage)
		league_slg = BattingStat.where(year => self.year).average(slugging_percentage)
		100 * ((obp / league_obp) + (slg / league_slg) - 1)
	end

	def career_isolated_power
		sprintf("%.3f", slg - avg)
	end

	def career_runs_created
		((career_hits + career_walks) * career_total_bases) / (career_at_bats + career_walks)
	end

	def career_secondary_average
		sprintf("%.3f", sec_avg)
	end

	def career_base_runs
		sprintf("%.3f", baseruns)
	end
	
	def career_batting_average
		sprintf("%.3f", avg)
	end
	
	def career_on_base_percentage
		sprintf("%.3f", obp)
	end
  
	def career_slugging_percentage
		sprintf("%.3f", slg)
	end

	def career_on_base_plus_slugging
		sprintf("%.3f", ops)
	end

	def career_at_bats_per_strikeout
		sprintf("%.2f", ab_per_k)
	end

	def career_at_bats_per_home_run
		sprintf("%.2f", ab_per_hr)
	end

	def career_adjusted_ops
		league_obp = BattingStat.where(year => self.year).average(on_base_percentage)
		league_slg = BattingStat.where(year => self.year).average(slugging_percentage)
		100 * ((obp / league_obp) + (slg / league_slg) - 1)
	end

	def career_isolated_power
		sprintf("%.3f", slg - avg)
	end

	def career_runs_created
		((career_hits + career_walks) * career_total_bases) / (career_at_bats + career_walks)
	end

	def career_secondary_average
		sprintf("%.3f", sec_avg)
	end

	def career_base_runs
		sprintf("%.3f", baseruns)
	end
	
	# Batting Post Stats
	def self.str_career_post_batting_average
		"career_hits_post * #{multiplier} / career_at_bats_post DESC"
	end
	
	def self.str_career_post_on_base_percentage
		"(career_hits_post + career_walks_post + career_hit_by_pitch_post) * #{multiplier} / (career_at_bats_post + career_walks_post + career_hit_by_pitch_post + career_sacrifice_flies_post) DESC"
	end

	def self.str_career_post_slugging_percentage
		"career_total_bases_post * #{multiplier} / career_at_bats_post DESC"
	end

	def self.str_career_post_on_base_plus_slugging
		"((career_hits_post + career_walks_post + career_hit_by_pitch_post) * #{multiplier} / (career_at_bats_post + career_walks_post + career_hit_by_pitch_post + career_sacrifice_flies_post)) + (career_total_bases_post * #{multiplier} / career_at_bats_post) DESC"
	end

	def self.str_career_post_stolen_base_percentage
		"career_stolen_bases_post * #{multiplier} / (career_stolen_bases_post + career_caught_stealing_post) DESC"
	end

	def self.str_career_post_at_bats_per_strikeout
		"career_at_bats_post * #{multiplier} / career_strikeouts_post DESC"
	end

	def self.str_career_post_at_bats_per_home_run
		"(career_at_bats_post * #{multiplier} / career_home_runs_post) ASC"
	end

  # def self.str_career_post_adjusted_ops
    # league_obp = BattingPostStat.where(year => self.year).average(on_base_percentage)
    # league_slg = BattingPostStat.where(year => self.year).average(slugging_percentage)
    # 100 * ((obp / league_obp) + (slg / league_slg) - 1)
  # end

  # def self.str_career_post_isolated_power
    # "#{str_career_post_slugging_percentage} - #{str_career_post_batting_average} DESC"
  # end

	def self.str_career_post_runs_created
		"((career_hits_post + career_walks_post) * career_total_bases_post) * #{multiplier} / (career_at_bats_post + career_walks_post) DESC"
	end

	def self.str_career_post_secondary_average
		"(career_total_bases_post - career_hits_post + career_walks_post + career_stolen_bases_post - career_caught_stealing_post) * #{multiplier} / career_at_bats_post DESC"
	end

	def self.str_career_post_base_runs
		"((career_hits_post + career_walks_post - career_home_runs_post) * ((1.4 * career_total_bases_post - 0.6 * career_hits_post - 3 * career_home_runs_post + 0.1 * career_walks_post) * 1.02)) * 10000/(((1.4 * career_total_bases_post - 0.6 * career_hits_post - 3 * career_home_runs_post + 0.1 * career_walks_post) * 1.02) + (career_at_bats_post - career_hits_post)) + career_home_runs_post * 10000 DESC"
	end
  
	def career_post_batting_average
		sprintf("%.3f", avg_post)
	end
	
	def career_post_on_base_percentage
		sprintf("%.3f", obp_post)
	end
  
	def career_post_slugging_percentage
		sprintf("%.3f", slg_post)
	end

	def career_post_on_base_plus_slugging
		sprintf("%.3f", ops_post)
	end

	def career_post_at_bats_per_strikeout
		sprintf("%.2f", ab_per_k_post)
	end

	def career_post_at_bats_per_home_run
		sprintf("%.2f", ab_per_hr_post)
	end

	# def career_post_adjusted_ops
		# league_obp = BattingStat.where(year => self.year).average(on_base_percentage)
		# league_slg = BattingStat.where(year => self.year).average(slugging_percentage)
		# 100 * ((obp / league_obp) + (slg / league_slg) - 1)
	# end

	# def career_post_isolated_power
		# sprintf("%.3f", slg_post - avg_post)
	# end

	def career_post_runs_created
		((career_hits_post + career_walks_post) * career_total_bases_post) / (career_at_bats_post + career_walks_post)
	end

	def career_post_secondary_average
		sprintf("%.3f", sec_avg_post)
	end

	def career_post_base_runs
		sprintf("%.3f", baseruns_post)
	end
  
	#Pitching
	
	def career_win_loss_percentage
		if (career_wins + career_losses) == 0
			sprintf("%.3f", 0)
		else sprintf("%.3f", (career_wins / (career_wins + career_losses).to_f))
		end
	end

	def career_innings_pitched_display
		ip = sprintf("%.1f", career_innings_pitched_outs / 3.to_f)
		if ip[ip.size-1] == '3'
			ip[ip.size-1] = '1'
		elsif ip[ip.size-1] == '7'
			ip[ip.size-1] = '2'
		else
		end
		ip
	end
	
	def career_innings_pitched
		career_innings_pitched_outs / 3.to_f
	end

	def career_era
		sprintf("%.2f", (career_earned_runs * 9) / career_innings_pitched.to_f)
	end

	def career_opponents_batting_average
		sprintf("%.3f", ((career_hits_allowed) / (career_batters_faced - career_walks_allowed - career_hit_by_pitch).to_f))
	end

	def career_walks_and_hits_innings_pitched
		sprintf("%.2f", ((career_walks_allowed + career_hits_allowed) / career_innings_pitched.to_f))
	end

	def career_hits_per_9_innings
		sprintf("%.2f", ((career_hits_allowed * 9) / (career_innings_pitched.to_f)))
	end

	def career_home_runs_per_9_innings
		sprintf("%.2f", ((career_home_runs_allowed * 9) / career_innings_pitched.to_f))
	end
  
	def career_walks_per_9_innings
		sprintf("%.2f", ((career_walks_allowed * 9) / career_innings_pitched.to_f))
	end

	def career_strikeouts_per_9_innings
		sprintf("%.2f", ((career_strikeouts_allowed * 9) / career_innings_pitched.to_f))
	end

	def career_strikeouts_per_walk
		sprintf("%.2f", ((career_strikeouts_allowed / career_walks_allowed.to_f)))
	end

	def career_adjusted_era
		league_era = PitchingStat.where(year => self.year).average(era)
		100 * (league_era / era)
	end
	
	def self.str_career_win_loss_percentage()
		"((career_wins * #{multiplier}) / (career_wins + career_losses)) DESC"
	end

	def self.str_career_innings_pitched
		"career_innings_pitched_outs * #{multiplier} / 3 DESC"
	end

	def self.str_career_era
		"((career_earned_runs * 9) * #{multiplier}) / (career_innings_pitched_outs / 3) ASC"
	end

	def self.str_career_opponents_batting_average
		"((career_hits_allowed * #{multiplier}) / (career_batters_faced - career_walks_allowed - career_hit_by_pitch)) ASC"
	end

	def self.str_career_walks_and_hits_innings_pitched
		"(career_walks_allowed + career_hits_allowed) * #{multiplier} / (career_innings_pitched_outs / 3) ASC"
	end

	def self.str_career_hits_per_9_innings
		"(career_hits_allowed * 9) * #{multiplier} / (career_innings_pitched_outs / 3) ASC"
	end

	def self.str_career_home_runs_per_9_innings
		"(career_home_runs_allowed * 9) * #{multiplier} / (career_innings_pitched_outs / 3) ASC"
	end

	def self.str_career_walks_per_9_innings
		"(career_walks_allowed * 9) * #{multiplier} / (career_innings_pitched_outs / 3) ASC"
	end

	def self.str_career_strikeouts_per_9_innings
		"(career_strikeouts_allowed * 9) * #{multiplier} / (career_innings_pitched_outs / 3) DESC"
	end

	def self.str_career_strikeouts_per_walk
		"(career_strikeouts_allowed * #{multiplier} / career_walks_allowed) DESC"
	end

	def self.str_career_adjusted_era
		league_era = PitchingStat.where(year => self.year).average(era)
		"100 * #{multiplier} * (#{league_era} / career_era) DESC"
	end
	
	#Pitching Post
	
	def career_post_win_loss_percentage
		if (career_wins_post + career_losses_post) == 0
			sprintf("%.3f", 0)
		else sprintf("%.3f", (career_wins_post / (career_wins_post + career_losses_post).to_f))
		end
	end

	def career_post_innings_pitched_display
		ip = sprintf("%.1f", career_innings_pitched_outs_post / 3.to_f)
		if ip[ip.size-1] == '3'
			ip[ip.size-1] = '1'
		elsif ip[ip.size-1] == '7'
			ip[ip.size-1] = '2'
		else
		end
		ip
	end
	
	def career_post_innings_pitched
		career_innings_pitched_outs_post / 3.to_f
	end

	def career_post_era
		puts (career_earned_runs_post * 9) 
		puts career_post_innings_pitched.to_f
		sprintf("%.2f", (career_earned_runs_post * 9) / career_post_innings_pitched.to_f)
	end

	def career_post_opponents_batting_average
		sprintf("%.3f", ((career_hits_allowed_post) / (career_batters_faced_post - career_walks_allowed_post - career_hit_by_pitch_post).to_f))
	end

	def career_post_walks_and_hits_innings_pitched
		sprintf("%.2f", ((career_walks_allowed_post + career_hits_allowed_post) / career_post_innings_pitched.to_f))
	end

	def career_post_hits_per_9_innings
		sprintf("%.2f", ((career_hits_allowed_post * 9) / (career_post_innings_pitched.to_f)))
	end

	def career_post_home_runs_per_9_innings
		sprintf("%.2f", ((career_home_runs_allowed_post * 9) / career_post_innings_pitched.to_f))
	end
  
	def career_post_walks_per_9_innings
		sprintf("%.2f", ((career_walks_allowed_post * 9) / career_post_innings_pitched.to_f))
	end

	def career_post_strikeouts_per_9_innings
		sprintf("%.2f", ((career_strikeouts_allowed_post * 9) / career_post_innings_pitched.to_f))
	end

	def career_post_strikeouts_per_walk
		sprintf("%.2f", ((career_strikeouts_allowed_post / career_walks_allowed_post.to_f)))
	end

	def career_post_adjusted_era
		league_era = PitchingStat.where(year => self.year).average(era)
		100 * (league_era / era)
	end
	
	def self.str_career_post_win_loss_percentage()
		"((career_wins_post * #{multiplier}) / (career_wins_post + career_losses_post)) DESC"
	end

	def self.str_career_post_innings_pitched
		"career_innings_pitched_outs_post * #{multiplier} / 3 DESC"
	end

	def self.str_career_post_era
		"(((career_earned_runs_post * 9) * #{multiplier}) / (career_innings_pitched_outs_post / 3)) ASC"
	end

	def self.str_career_post_opponents_batting_average
		"((career_hits_allowed_post * #{multiplier}) / (career_batters_faced_post - career_walks_allowed_post - career_hit_by_pitch_post)) ASC"
	end

	def self.str_career_post_walks_and_hits_innings_pitched
		"(career_walks_allowed_post + career_hits_allowed_post) * #{multiplier} / (career_innings_pitched_outs_post / 3) ASC"
	end

	def self.str_career_post_hits_per_9_innings
		"(career_hits_allowed_post * 9) * #{multiplier} / (career_innings_pitched_outs_post / 3) ASC"
	end

	def self.str_career_post_home_runs_per_9_innings
		"(career_home_runs_allowed_post * 9) * #{multiplier} / (career_innings_pitched_outs_post / 3) ASC"
	end

	def self.str_career_post_walks_per_9_innings
		"(career_walks_allowed_post * 9) * #{multiplier} / (career_innings_pitched_outs_post / 3) ASC"
	end

	def self.str_career_post_strikeouts_per_9_innings
		"(career_strikeouts_allowed_post * 9) * #{multiplier} / (career_innings_pitched_outs_post / 3) DESC"
	end

	def self.str_career_post_strikeouts_per_walk
		"(career_strikeouts_allowed_post * #{multiplier} / career_walks_allowed_post) DESC"
	end

	def self.str_career_post_adjusted_era
		league_era = PitchingStat.where(year => self.year).average(era)
		"100 * #{multiplier} * (#{league_era} / career_post_era) DESC"
	end
	
	#Fielding
	
	def career_innings
		career_inning_outs / 3
	end

	def career_fielding_percentage
		sprintf("%.3f", ((career_put_outs + career_assists) / career_chances) )
	end

	def career_range_factor_innings
		sprintf("%.3f", rfi)
	end

	def career_range_factor_game
		sprintf("%.3f", rfg)
	end
	
	def self.str_career_fielding_percentage
		"(career_put_outs + career_assists) * #{multiplier} / career_chances "
	end
	
	def self.str_career_range_factor_innings
		"(9* (career_put_outs + career_assists)) * #{multiplier} / (career_inning_outs / 3) "
	end
	
	def self.str_career_range_factor_game
		"(career_put_outs + career_assists) * #{multiplier} / career_games "
	end
	
	#Fielding_Post
	
	def career_post_innings
		career_inning_outs_post / 3
	end

	def career_post_fielding_percentage
		sprintf("%.3f", ((career_put_outs_post + career_assists_post) / career_chances_post) )
	end

	def career_post_range_factor_innings
		sprintf("%.3f", rfi_post)
	end

	def career_range_factor_game
		sprintf("%.3f", rfg_post)
	end
	
	def self.str_career_post_fielding_percentage
		"(career_put_outs_post + career_assists_post) * #{multiplier} / career_chances_post"
	end
	
	def self.str_career_post_range_factor_innings
		"(9* (career_put_outs_post + career_assists_post)) * #{multiplier} / (career_inning_outs_post / 3) "
	end
	
	def self.str_career_post_range_factor_game
		"(career_put_outs_post + career_assists_post) * #{multiplier} / career_games_post "
	end
	
	private

	def avg
		career_hits / career_at_bats.to_f
	end

	def obp
		(career_hits + career_walks + career_hit_by_pitch) / (career_at_bats + career_walks + career_hit_by_pitch + career_sacrifice_flies).to_f
	end

	def slg
		career_total_bases / career_at_bats.to_f
	end

	def ops
		obp + slg
	end

	def ab_per_k
		career_at_bats / career_strikeouts.to_f
	end

	def ab_per_hr
		career_at_bats / career_home_runs.to_f
	end

	def sec_avg
		(career_total_bases - career_hits + career_walks + career_stolen_bases - career_caught_stealing) / career_at_bats.to_f
	end

	def baseruns
		a = career_hits + career_walks - career_home_runs
		b = (1.4 * career_total_bases - 0.6 * career_hits - 3 * career_home_runs + 0.1 * career_walks) * 1.02
		c = career_at_bats - career_hits
		d = career_home_runs
		(a * b)/(b + c) + d
	end
	
	def avg_post
		career_hits_post / career_at_bats_post.to_f
	end

	def obp_post
		(career_hits_post + career_walks_post + career_hit_by_pitch_post) / (career_at_bats_post + career_walks_post + career_hit_by_pitch_post + career_sacrifice_flies_post).to_f
	end

	def slg_post
		career_total_bases_post / career_at_bats_post.to_f
	end

	def ops_post
		obp_post + slg_post
	end

	def ab_per_k_post
		career_at_bats_post / career_strikeouts_post.to_f
	end

	def ab_per_hr_post
		career_at_bats_post / career_home_runs_post.to_f
	end

	def sec_avg_post
		(career_total_bases_post - career_hits_post + career_walks_post + career_stolen_bases_post - career_caught_stealing_post) / career_at_bats_post.to_f
	end

	def baseruns_post
		a = career_hits_post + career_walks_post - career_home_runs_post
		b = (1.4 * career_total_bases_post - 0.6 * career_hits_post - 3 * career_home_runs_post + 0.1 * career_walks_post) * 1.02
		c = career_at_bats_post - career_hits_post
		d = career_home_runs_post
		(a * b)/(b + c) + d
	end
	
	def rfi
		(9 * (career_put_outs + career_assists) / career_innings.to_f)
	end
	
	def rfg
		(career_put_outs + career_assists) / career_games.to_f
	end
	
	def rfi_post
		(9 * (career_put_outs_post + career_assists_post) / career_post_innings_post.to_f)
	end
	
	def rfg_post
		(career_put_outs_post + career_assists_post) / career_games_post.to_f
	end

end
