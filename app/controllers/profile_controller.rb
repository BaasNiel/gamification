class ProfileController < ApplicationController
  before_action :set_user

  def index
    @user_achievements = @user.user_achievements.order("date_achieved DESC, created_at DESC")
    @week_string = get_week_string
  end

  # This function returns a string that displays the current week range,
  # based on the team's first-day-of-week setting
  def get_week_string
    team = @user.team
    start_of_week = Time.now.beginning_of_week(team.start_of_week_symbol)
    end_of_week = Time.now.end_of_week(team.start_of_week_symbol)

    start_string = start_of_week.strftime("%d %b %Y")
    end_string = end_of_week.strftime("%d %b %Y")

    start_string + " - " + end_string
  end

  def set_user
    if @user
      @user
    elsif params[:id].present?
      @user = User.find params[:id]
    else
      @user = current_user
    end
  end
end
