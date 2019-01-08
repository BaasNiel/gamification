class Sprint < ApplicationRecord
  belongs_to :user

  def start_date_formatted
    self.start_date.strftime("%x %X %Z")
  end

  def end_date_formatted
    self.end_date.strftime("%x %X %Z")
  end
end
