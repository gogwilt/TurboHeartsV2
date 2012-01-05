class AddAllPlayersToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :all_players, :boolean
  end
end
