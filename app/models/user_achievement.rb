class UserAchievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievement

  def date_achieved_formatted
    if self.date_achieved.present?
      date_achieved = self.date_achieved
    else
      date_achieved = self.created_at
    end

    date_achieved
  end
end
