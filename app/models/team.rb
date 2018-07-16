class Team < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :users
  has_many :achievements
  has_one :admin, class_name: "User"

  # Returns a symbol for the team's start of week.
  # If nothing is set, :monday is returned
  def start_of_week_symbol
    if self.start_of_week.present?
      self.start_of_week.to_sym
    else
      :monday
    end
  end
end
