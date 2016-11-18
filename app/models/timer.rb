class Timer < ActiveRecord::Base

  belongs_to :player

  # ALTERNATIVE start and stop methods
  
  # def start_time
  #   @running = true
  #   @start_time = Time.now

  #   limit if @time_limit

  #   self
  # end

  # def stop_time
  #   if @running
  #     defuse
  #     @end_time = Time.now
  #     @running = false
  #     @total_time += (@end_time - @start_time)
  #   else
  #     nil
  #   end
  # end


  def start_time
    Timer.create(player_id: current_player.id, time: Time.now)
  end

  def stop_time
    last_attempt = Timer.where(player_id: current_player.id).last_attempt
    if (last_attempt.time + 5.minutes) < Time.now   # time is up
      return false
    end
  end

  def timer_reset
    if running?
      r = stop
    else
      r = 0
    end
    @total_time = 0
    return r
  end
end