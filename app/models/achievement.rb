class Achievement < ApplicationRecord
  has_many :user_achievements, dependent: :destroy
  has_many :users, :through => :user_achievements

  belongs_to :team
  has_one :pomodoro_achievement, foreign_key: :pomodoro_achievement_id
end
