class SprintsController < ApplicationController
  def index
    if current_user.admin?
      @sprints = Sprint.all
    else
      @sprints = current_user.team.sprints
    end
  end

  def new
    @sprint = Sprint.new
  end
end
