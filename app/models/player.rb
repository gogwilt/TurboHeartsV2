class Player < ActiveRecord::Base
  has_many :points
  has_many :rounds, :through => :points
  
  def winnings
    self.points.inject(0) {|cumulative, point| cumulative + point.dollar_value}
  end
end
