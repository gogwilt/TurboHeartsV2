class Player < ActiveRecord::Base
  attr_accessible :name
  
  has_many :points
  has_many :rounds, :through => :points
  belongs_to :user
  
  validates_presence_of :name
  
  def winnings
    self.points.inject(0) {|cumulative, point| cumulative + point.dollar_value}
  end
end
