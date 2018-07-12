class PomodorosController < ApplicationController
  def index
    @pomodoros = Pomodoro.where user: current_user
  end
end
