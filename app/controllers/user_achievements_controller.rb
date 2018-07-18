class UserAchievementsController < ApplicationController
  def index
    if params[:id].present?
      user = User.find_by(id: params[:id])

      if !user || (current_user.team != user.team && !current_user.admin?)
        redirect_to root_url, :alert => "You can't access that page"
      end
    else
      user = current_user
    end

    @earned_achievements = UserAchievement.where(user: user)
    @user = user
  end
end
