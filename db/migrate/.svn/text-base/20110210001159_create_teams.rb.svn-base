class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.integer :franchise_id
      t.integer :division_id
      t.integer :year
      t.string :baseball_era
      t.string :name
      t.string :park
      t.integer :attendance
      t.integer :rank
      t.integer :games
      t.integer :home_games
      t.integer :wins
      t.integer :losses
      t.boolean :div_win
      t.boolean :wc_win
      t.boolean :lg_win
      t.boolean :ws_win
      t.integer :runs
      t.integer :plate_appearances
      t.integer :at_bats
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :total_bases
      t.integer :extra_base_hits
      t.integer :walks
      t.integer :strikeouts
      t.integer :stolen_bases
      t.integer :caught_stealing
      t.integer :hit_by_pitch
      t.integer :sacrifice_flies
      t.integer :runs_allowed
      t.integer :earned_runs
      t.integer :complete_games
      t.integer :shutouts
      t.integer :saves
      t.integer :innings_pitched_outs
      t.integer :hits_allowed
      t.integer :home_runs_allowed
      t.integer :walks_allowed
      t.integer :strikeouts_allowed
      t.integer :errors_made
      t.integer :double_plays
      t.float :fielding_percentage
      t.integer :batters_park_factor
      t.integer :pitchers_park_factor
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
