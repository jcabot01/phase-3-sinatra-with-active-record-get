class User < ActiveRecord::Base
  #associated models
  has_many :reviews
  has_many :games, through: :reviews
end
