class Player < ActiveRecord::Base
  attr_accessible :name
  
  has_many :points
  has_many :rounds, :through => :points
  has_one :user
  
  validates_presence_of :name
  
  def winnings
    self.points.inject(0) {|cumulative, point| cumulative + point.dollar_value}
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
end
