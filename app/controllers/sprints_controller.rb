class SprintsController < ApplicationController
  def index
    if current_user.admin?
      @sprints = Sprint.all.page params[:page]
    else
      @sprints = current_user.team.sprints.page params[:page]
    end
  end

  def new
    @sprint = Sprint.new
  end
end
