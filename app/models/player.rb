class Player < ActiveRecord::Base
  attr_accessible :name
  
  has_many :points
  has_many :rounds, :through => :points
  has_one :user
  
  has_and_belongs_to_many :leagues
  
  validates :name, :presence => true, 
                   :uniqueness => :true,
                   :length => {:minimum => 3, :maximum => 254}
  
  def self.search(search)
    if search
      user_players = User.find(:all, :conditions => ['email LIKE ?', "%#{search}%"]).map {|user| user.player}
      return Player.find(:all, :conditions => ['name LIKE ?', "%#{search}%"]) | user_players
    else
      return Player.all
    end
  end
  
  def winnings
    winnings_for_points self.points
  end
  
  def winnings_until_time time
    winnings_for_points self.points.where("created_at <= ?", time)
  end
  
  def winnings_for_points points
    points.inject(0) {|cumulative, point| cumulative + point.dollar_value}
  end
  
  def players_in_clique
    clique = []
    add_to_clique = [self]
    until add_to_clique.empty?
      player = add_to_clique.pop
      unless clique.include? player
        player.direct_opponents.each {|opponent| add_to_clique << opponent}
        add_to_clique.uniq!
        clique << player
      end
    end
    clique
  end
  
  def direct_opponents
    self.rounds.map{|round| round.players}.flatten.uniq
  end
  
  def winnings_against_opponent(opponent)
    if opponent == self
      return 0
    end
    winnings = 0
    self.rounds.each do |round|
      my_points = round.points.find_by_player_id(self.id)
      round.points.each do |point|
        if point.player == opponent
          winnings += point.value - my_points.value
        end
      end
    end
    winnings
  end
end
