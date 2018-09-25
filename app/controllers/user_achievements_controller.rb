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

    @earned_achievements = UserAchievement
                            .where(user: user)
                            .order("date_achieved DESC, created_at DESC")
                            .page params[:page]

    @user = user
  end

  def show_name_in_title
    params[:id].present? && params[:id].present? != current_user.id
  end

  helper_method :show_name_in_title
end
