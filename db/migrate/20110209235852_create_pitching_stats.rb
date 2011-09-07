class CreatePitchingStats < ActiveRecord::Migration
  def self.up
    create_table :pitching_stats do |t|
      t.integer :player_id
      t.integer :team_id
      t.integer :stint
      t.integer :wins
      t.integer :losses
      t.integer :games
      t.integer :games_started
      t.integer :complete_games
      t.integer :shutouts
      t.integer :saves
      t.integer :innings_pitched_outs
      t.integer :hits
      t.integer :earned_runs
      t.integer :home_runs
      t.integer :walks
      t.integer :strikeouts
      t.integer :intentional_walks
      t.integer :wild_pitches
      t.integer :hit_by_pitch
      t.integer :balks
      t.integer :batters_faced
      t.integer :games_finished
      t.integer :runs
      t.integer :sacrifice_hits
      t.integer :sacrifice_flies
      t.integer :grounded_into_double_plays
      t.timestamps
    end
  end

  def self.down
    drop_table :pitching_stats
  end
end
