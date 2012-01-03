class AddPlayerIdToUsersAndRemoveUserIdFromPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :user_id
    remove_column :users, :name
    add_column :users, :player_id, :integer
  end
end
