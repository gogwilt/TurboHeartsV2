class Round < ActiveRecord::Base
  has_many :points
  has_many :players, :through => :points
end
