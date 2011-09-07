class CreateFieldingPostStats < ActiveRecord::Migration
  def self.up
    create_table :fielding_post_stats do |t|
      t.integer :player_id
      t.integer :team_id
      t.string :round
      t.string :position
      t.integer :games
      t.integer :games_started
      t.integer :inning_outs
      t.integer :chances
      t.integer :put_outs
      t.integer :assists
      t.integer :errors_made
      t.integer :double_plays
      t.integer :triple_plays
      t.integer :passed_balls
      t.integer :stolen_bases
      t.integer :caught_stealing
      t.timestamps
    end
  end

  def self.down
    drop_table :fielding_post_stats
  end
end
