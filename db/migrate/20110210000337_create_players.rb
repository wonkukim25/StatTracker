class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
	  t.string :name
      t.string :nickname
      t.integer :birth_year
      t.integer :birth_month
      t.integer :birth_day
      t.string :birth_country
      t.string :birth_state
      t.string :birth_city
      t.integer :death_year
      t.integer :death_month
      t.integer :death_day
      t.string :death_country
      t.string :death_state
      t.string :death_city
      t.integer :weight
      t.integer :height
      t.string :bats
      t.string :throws
      t.datetime :debut
      t.datetime :final_game
      t.string :college
      t.boolean :hof
	  t.integer :career_plate_appearances
	  t.integer :career_at_bats
	  t.integer :career_hits
	  t.integer :career_home_runs
	  t.integer :career_total_bases
	  t.integer :career_stolen_bases
	  t.integer :career_caught_stealing
	  t.integer :career_walks
	  t.integer :career_strikeouts
	  t.integer :career_hit_by_pitch
	  t.integer :career_sacrifice_flies
	  t.integer :career_plate_appearances_post
	  t.integer :career_at_bats_post
	  t.integer :career_hits_post
	  t.integer :career_home_runs_post
	  t.integer :career_total_bases_post
	  t.integer :career_stolen_bases_post
	  t.integer :career_caught_stealing_post
	  t.integer :career_walks_post
	  t.integer :career_strikeouts_post
	  t.integer :career_hit_by_pitch_post
	  t.integer :career_sacrifice_flies_post
	  t.integer :career_wins
	  t.integer :career_losses
	  t.integer :career_innings_pitched_outs
	  t.integer :career_earned_runs
	  t.integer :career_runs_allowed
	  t.integer :career_hits_allowed
	  t.integer :career_batters_faced
	  t.integer :career_walks_allowed
	  t.integer :career_hit_by_pitches_allowed
	  t.integer :career_home_runs_allowed
	  t.integer :career_strikeouts_allowed
	  t.integer :career_wins_post
	  t.integer :career_losses_post
	  t.integer :career_innings_pitched_outs_post
	  t.integer :career_earned_runs_post
	  t.integer :career_runs_allowed_post
	  t.integer :career_hits_allowed_post
	  t.integer :career_batters_faced_post
	  t.integer :career_walks_allowed_post
	  t.integer :career_hit_by_pitches_allowed_post
	  t.integer :career_home_runs_allowed_post
	  t.integer :career_strikeouts_allowed_post
	  t.integer :career_put_outs
	  t.integer :career_assists
	  t.integer :career_inning_outs
	  t.integer :career_games
	  t.integer :career_put_outs_post
	  t.integer :career_assists_post
	  t.integer :career_inning_outs_post
	  t.integer :career_games_post
	  t.timestamps
    end

  def self.down
    drop_table :players
  end

end

end