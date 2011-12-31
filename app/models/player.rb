class Player < ActiveRecord::Base
  has_many :points
  has_many :rounds, :through => :points
  
  validates_presence_of :name
  
  def winnings
    self.points.inject(0) {|cumulative, point| cumulative + point.dollar_value}
  end
end
