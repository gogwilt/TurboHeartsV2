class Round < ActiveRecord::Base
  has_many :points
  has_many :players, :through => :points
  
  def points_sorted
    points.sort_by {|point| point.value}
  end
end
