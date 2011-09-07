class CreateBattingStats < ActiveRecord::Migration
  def self.up
    create_table :batting_stats do |t|
      t.integer :player_id
      t.integer :team_id
      t.integer :stint
      t.integer :games
      t.integer :games_batting
      t.integer :plate_appearances
      t.integer :at_bats
      t.integer :runs
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :total_bases
      t.integer :extra_base_hits
      t.integer :rbi
      t.integer :stolen_bases
      t.integer :caught_stealing
      t.integer :walks
      t.integer :strikeouts
      t.integer :intentional_walks
      t.integer :hit_by_pitch
      t.integer :sacrifice_hits
      t.integer :sacrifice_flies
      t.integer :grounded_into_double_plays
      t.timestamps
    end
  end

  def self.down
    drop_table :batting_stats
  end
end
