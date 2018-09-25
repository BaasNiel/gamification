module PomodoroHelper
  def seconds_to_timer_str(seconds)
    sprintf "%02d:%02d", (seconds / 60).floor, seconds % 60
  end

  def to_display_time(datetime)
    if datetime && datetime.respond_to?(:localtime)
      datetime.localtime.strftime("%Y/%m/%d %H:%M:%S")
    end
  end
end
