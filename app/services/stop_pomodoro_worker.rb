class StopPomodoroWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(pomodoro_id, enable_notification = false)
    pomodoro = Pomodoro.find(pomodoro_id)
    if pomodoro.remaining_seconds > 0
      fail "Pomodoro(#{pomodoro_id}) still has #{pomodoro.remaining_seconds} seconds."
    else
      pomodoro.stop!

      user = pomodoro.user
      team = user.team
      achievement = team.pomodoro_achievement

      if achievement
        UserAchievement.create(user: user, achievement: achievement)
      end
    end
  end
end
