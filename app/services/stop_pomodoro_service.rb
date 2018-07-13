require 'sidekiq/api'

class StopPomodoroService
  class << self
    def create(pomodoro)
      StopPomodoroWorker.perform_in(pomodoro.remaining_seconds, pomodoro.id, true)
    end

    def destroy(pomodoro)
      Sidekiq::ScheduledSet.new.each do |entry|
        entry.delete if fetch_pomodoro_id(entry) == pomodoro.id
      end
    end

    private

    def fetch_pomodoro_id(entry)
      entry.item["args"].first.to_i
    end
  end
end
