class ProfileController < ApplicationController
  def index
    if params[:id].present?
      @user = User.find params[:id]
    else
      @user = current_user
    end

    @user_achievements = @user.user_achievements.order("date_achieved DESC, created_at DESC")
  end
end
