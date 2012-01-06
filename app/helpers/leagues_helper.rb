module LeaguesHelper
  def get_a_league_for_player(player)
    League.all.each do |l|
      if l.get_players.include? player
        return l
      end
    end
    return nil    
  end
end
