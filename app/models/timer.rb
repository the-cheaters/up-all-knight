class Timer < ActiveRecord::Base

  belongs_to :player
  belongs_to :game

  def initialize
    @start_time = nil
    @stop_time = nil
    @running = false
    @time_left = 500
  end

  def start
    @time_left 
    @running = true 
    @start_time = Time.now.round(0)
  end
  
  def stop
    if @running
      @stop_time = Time.now.round(0)
      @running = false
      @time_left = @time_left - elapsed_time
    end
    @stop_time
  end

  def elapsed_time
    @stop_time - @start_time
  end      
end
