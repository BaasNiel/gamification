class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  has_many :user_achievements
  has_many :achievements, :through => :user_achievements

  belongs_to :team

  def earned_achievements
    self.user_achievements.map(&:achievement)
  end

  def total_points
    earned_achievements.map(&:points).sum
  end
end
