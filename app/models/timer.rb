class Timer < ActiveRecord::Base

  belongs_to :player
  belongs_to :game

  def initialize
    @start_time = nil
    @stop_time = nil
    @running = false
    @time_left = 0
  end

  def start  
    @running = true 
    @start_time = Time.now.round(0)
  end
  
  def stop
    if @running
      @stop_time = Time.now.round(0)
      @running = false
    end
    @stop_time
  end      
end
