class Enrollment < ActiveRecord::Base
  belongs_to :game
  has_many :players

  def join_game(game)
    @enrollments = Enrollments.create
  end
end
