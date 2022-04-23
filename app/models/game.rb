class Game < ActiveRecord::Base
  #associated models
  has_many :reviews
  has_many :users, through: :reviews
end
