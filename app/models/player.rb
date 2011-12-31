class Player < ActiveRecord::Base
  attr_accessible :name
  
  has_many :points
  has_many :rounds, :through => :points
  belongs_to :user
  
  validates_presence_of :name
  
  def display_name
    user.nil? ? self.name : user.name
  end
  
  def winnings
    self.points.inject(0) {|cumulative, point| cumulative + point.dollar_value}
  end
end
