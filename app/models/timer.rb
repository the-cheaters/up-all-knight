class Timer < ActiveRecord::Base
  
  # attr_accessor :start!
  # attr_accessor :stop!
  
  belongs_to :player
  belongs_to :game
  
  
  def start!
    self.running = true
    self.start_time = Time.now
    save
  end
  
  def stop!
    if self.running
      @time_left = self.time_left
      @stop_time = Time.now
      self.running = false
      @time_left -= (@stop_time.to_i - self.start_time.to_i)
      if @time_left < 0
        self.time_left = 0
      else
        self.time_left = @time_left
      end
      save
    end
  end
  
end
