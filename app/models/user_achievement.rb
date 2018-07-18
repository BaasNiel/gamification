class UserAchievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievement

  def date_achieved_formatted
    display_format = "%d %b %Y @ %H:%M:%S"

    if self.date_achieved.present?
      date_achieved = self.date_achieved.strftime(display_format)
    else
      date_achieved = self.created_at.strftime(display_format)
    end

    date_achieved
  end
end
