class Pomodoro < ApplicationRecord
  belongs_to :user

  INITIAL_TIME = 25 * 60

  class Status
    include Ruby::Enum

    define :INITIAL,   "INITIAL"
    define :RUNNING,   "RUNNING"
    define :PAUSED,    "PAUSED"
    define :COMPLETED, "COMPLETED"
  end

  has_many :pauses, dependent: :destroy

  class << self
    def current_pomodoro(user)
      pomodoro = Pomodoro.where(user: user).order("id desc").first
      if pomodoro.nil? || pomodoro.status == Status::COMPLETED
        Pomodoro.new
      else
        pomodoro
      end
    end

    def start(user)
      return false if Pomodoro.current_pomodoro(user).active?
      pomodoro = Pomodoro.create(start_time: Time.zone.now, user: user)

      if pomodoro
        ActionCable.server.broadcast 'team_channel', message: "started"
        return pomodoro
      end
    end
  end

  def active?
    [Status::RUNNING, Status::PAUSED].include?(status)
  end

  def stop
    return false unless status == Status::PAUSED
    stop!
  end

  def stop!
    update!(end_time: Time.zone.now)
    ActionCable.server.broadcast 'team_channel', message: "stopped"
    complete_pauses
  end

  def pause
    return false unless status == Status::RUNNING
    pauses.create!(start_time: Time.zone.now)
    ActionCable.server.broadcast 'team_channel', message: "paused"
  end

  def resume
    return false unless status == Status::PAUSED
    complete_pauses
    ActionCable.server.broadcast 'team_channel', message: "resumed"
  end

  def status
    if start_time.nil?
      Status::INITIAL
    else
      if !end_time.nil?
        Status::COMPLETED
      else
        paused? ? Status::PAUSED : Status::RUNNING
      end
    end
  end

  def passed_seconds
    return 0 unless start_time
    ((end_time || Time.zone.now) - start_time).to_i
  end

  def remaining_seconds
    case status
    when Status::INITIAL   then INITIAL_TIME
    when Status::RUNNING   then calculate_remaining_seconds
    when Status::PAUSED    then calculate_remaining_seconds
    when Status::COMPLETED then 0
    end
  end

  def start_time_formatted
    self.start_time.strftime("%x %X")
  end

  def end_time_formatted
    self.end_time.strftime("%x %X")
  end

  private

  def calculate_remaining_seconds
    paused    = pauses.reduce(0) { |a, e| a + e.duration }
    remaining = INITIAL_TIME - (passed_seconds - paused)

    [remaining, 0].max
  end

  def complete_pauses
    pauses.each(&:complete)
  end

  def paused?
    pauses.any?(&:active?)
  end
end
