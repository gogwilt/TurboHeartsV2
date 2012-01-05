class League < ActiveRecord::Base
  attr_accessible :name, :description, :start_date, :end_date, :all_players
  
  validates_presence_of :name
  validates_presence_of :description
  
  has_and_belongs_to_many :players
  
  # Clunky way to account for default league
  def get_players
    the_players = self.players
    if self.all_players and self.players.size > 0
      # This logic is probably unnecessary. The default league should only have
      # one player.
      unaccounted_players = self.players
      until unaccounted_players.empty?
        the_players |= unaccounted_players[0].players_in_clique
        unaccounted_players -= the_players
      end
    else
      the_players = self.players
    end
    return the_players
  end
end
