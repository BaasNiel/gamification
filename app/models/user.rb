class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  has_many :user_achievements
  has_many :achievements, :through => :user_achievements
  has_many :pomodoros, dependent: :destroy

  belongs_to :team

  def full_name
    self.first_name + " " + self.last_name
  end

  def achievements_earned
    self.user_achievements.map(&:achievement)
  end

  def total_points_earned
    achievements_earned.map(&:points).sum
  end

  # The number of times a user has earned a specific achievement
  def times_earned(achievement)
    self.user_achievements.map(&:achievement_id).count(achievement.id)
  end

  def points_this_week
    team = self.team
    start_of_week = Time.now.beginning_of_week(team.start_of_week_symbol)
    user_achievements = self.user_achievements.where(date_achieved: start_of_week..Time.now)
    achievements_earned = user_achievements.map(&:achievement)
    achievements_earned.map(&:points).sum
  end

  def points_last_week
    team = self.team
    start_of_week = Time.now.beginning_of_week(team.start_of_week_symbol)
    start_of_last_week = start_of_week - 7.days
    end_of_last_week = start_of_week - 1.second
    user_achievements = self.user_achievements.where(date_achieved: start_of_last_week..end_of_last_week)
    achievements_earned = user_achievements.map(&:achievement)
    achievements_earned.map(&:points).sum
  end

  def pomodoros_this_week
    team = self.team
    start_of_week = Time.now.beginning_of_week(team.start_of_week_symbol)
    pomodoros_completed = self.pomodoros.where(end_time: start_of_week..Time.now)
    pomodoros_completed.count
  end

  def pomodoros_last_week
    team = self.team
    start_of_week = Time.now.beginning_of_week(team.start_of_week_symbol)
    start_of_last_week = start_of_week - 7.days
    end_of_last_week = start_of_week - 1.second
    pomodoros_completed = self.pomodoros.where(end_time: start_of_last_week..end_of_last_week)
    pomodoros_completed.count
  end

  def pomodoros_today
    pomodoros_completed = self.pomodoros.where(end_time: DateTime.now.beginning_of_day..DateTime.now.end_of_day)
    pomodoros_completed.count
  end

  def current_pomodoro
    if pomodoro_in_progress?
      self.pomodoros.last
    else
      nil
    end
  end

  def pomodoro_in_progress?
    @pomodoro = self.pomodoros.last
    if @pomodoro
      @pomodoro.status == Pomodoro::Status::RUNNING || @pomodoro.status == Pomodoro::Status::PAUSED
    else
      false
    end
  end
end
