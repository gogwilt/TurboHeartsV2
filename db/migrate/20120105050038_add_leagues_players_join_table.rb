class AddLeaguesPlayersJoinTable < ActiveRecord::Migration
  def up
    create_table :leagues_players, :id => false do |t|
      t.integer :league_id
      t.integer :player_id
    end
  end

  def down
    drop_table :leagues_players
  end
end
