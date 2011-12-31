class Point < ActiveRecord::Base
  belongs_to :round
  belongs_to :player
  
  def dollar_value
    total_points = self.round.points.inject(0) {|cumulative, point| cumulative + point.value}
    total_points - self.value * 5
  end
end
