class StopPomodoroWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(pomodoro_id, enable_notification = false)
    pomodoro = Pomodoro.find(pomodoro_id)
    if pomodoro.remaining_seconds > 0
      fail "Pomodoro(#{pomodoro_id}) still has #{pomodoro.remaining_seconds} seconds."
    else
      pomodoro.stop!
      # Here we'll assign an achievement or something, most likely
    end
  end
end
