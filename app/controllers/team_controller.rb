class TeamController < ApplicationController

  def index
    @team = current_user.team
    @users = @team.users
  end

end
