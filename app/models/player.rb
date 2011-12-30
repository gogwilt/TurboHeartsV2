class Player < ActiveRecord::Base
  has_many :points
  has_many :round, :through => :points
end
