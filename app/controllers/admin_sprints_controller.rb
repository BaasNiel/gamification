class AdminSprintsController < ApplicationController
  def index
    @sprints = Sprint.all
  end
end
