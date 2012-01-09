class Point < ActiveRecord::Base
  attr_accessible :round, :player, :dollar_value
  
  belongs_to :round
  belongs_to :player
  
  validates_presence_of :player
  validates_presence_of :round
  validates_presence_of :value
  
  def calculate_dollar_value
    total_points = self.round.points.inject(0) {|cumulative, point| cumulative + point.value}
    self.dollar_value = total_points - self.value * 4
  end
end
