class StaticPagesController < ApplicationController
  def index
  end

  def ranking
    @players = Player.where.not(wins: 0).order('wins DESC, losses ASC').limit(10)
  end
end
