class Review < ActiveRecord::Base
  #associated models
  belongs_to :game
  belongs_to :user
end
