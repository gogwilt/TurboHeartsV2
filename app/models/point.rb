class Point < ActiveRecord::Base
  belongs_to :round
  belongs_to :player
  
  validates_presence_of :player
  validates_presence_of :round
  validates_presence_of :value
  
  def dollar_value
    total_points = self.round.points.inject(0) {|cumulative, point| cumulative + point.value}
    total_points - self.value * 5
  end
end
