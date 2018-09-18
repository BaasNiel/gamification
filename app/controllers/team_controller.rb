class TeamController < ApplicationController

  def index
    @team = current_user.team
  end

end
