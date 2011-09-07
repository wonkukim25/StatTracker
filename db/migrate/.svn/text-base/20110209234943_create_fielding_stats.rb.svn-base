class CreateFieldingStats < ActiveRecord::Migration
  def self.up
    create_table :fielding_stats do |t|
      t.integer :player_id
      t.integer :team_id
      t.integer :stint
      t.string :position
      t.integer :games
      t.integer :games_started
      t.integer :inning_outs
      t.integer :chances
      t.integer :put_outs
      t.integer :assists
      t.integer :errors_made
      t.integer :double_plays
      t.integer :passed_balls
      t.integer :wild_pitches
      t.integer :stolen_bases
      t.integer :caught_stealing
      t.integer :zone_rating
      t.timestamps
    end
  end

  def self.down
    drop_table :fielding_stats
  end
end
