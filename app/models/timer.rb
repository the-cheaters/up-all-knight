class Timer < ActiveRecord::Base
  after_initialize do |timer|
  end

  belongs_to :player
  belongs_to :game

  def start
    @time_left = self.time_left
    @running = true 
    @start_time = Time.now.round(0)
  end
  
  def stop
    if @running
      @stop_time = Time.now.round(0)
      @running = false
      self.time_left = @time_left.to_i - elapsed_time
    end
    @stop_time
  end

  def elapsed_time
    @stop_time - @start_time
  end      
end
