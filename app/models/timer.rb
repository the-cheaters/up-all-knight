class Timer < ActiveRecord::Base

  belongs_to :player
  belongs_to :game

  def start!
    self.running = true 
    self.start_time = Time.now
  end
  
  def stop!
    if self.running
      @stop_time = Time.now
      self.running = false
      @time_left = @time_left.to_i - elapsed_time.to_i
    end
  end

  def elapsed_time
    @stop_time - self.start_time
  end      
end
