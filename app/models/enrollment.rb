class Enrollment < ActiveRecord::Base

  belongs_to :game
  has_many :players
end
