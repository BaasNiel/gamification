class Pause < ApplicationRecord
  belongs_to :pomodoro, counter_cache: true

  def active?
    end_time.nil?
  end

  def complete
    update!(end_time: Time.zone.now) unless end_time
  end

  def duration
    ((end_time || Time.zone.now) - start_time).to_i
  end
end
