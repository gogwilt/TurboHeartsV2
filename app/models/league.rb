class League < ActiveRecord::Base
  attr_accessible :name, :description, :start_date, :end_date, :all_players
  
  validates_presence_of :name
  validates_presence_of :description
  
  has_and_belongs_to_many :players
  
  # Add all players in the playing clique to this league.
  def update_all_players
    if self.all_players and self.players.size > 0
      unaccounted_players = self.players
      until unaccounted_players.empty?
        self.players |= unaccounted_players[0].players_in_clique
        unaccounted_players -= self.players
      end
    end
  end
end
