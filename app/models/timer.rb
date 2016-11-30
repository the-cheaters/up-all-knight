class Timer < ActiveRecord::Base

  belongs_to :player
  belongs_to :game

  def start!
    @time_left = self.time_left
    @running = true 
    @start_time = Time.now
  end
  
  def stop!
    if @running
      @stop_time = Time.now
      @running = false
      self.time_left = @time_left.to_i - elapsed_time.to_i
    end
  end

  def elapsed_time
    @stop_time - @start_time
  end      
end
