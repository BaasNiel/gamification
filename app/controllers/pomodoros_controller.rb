class PomodorosController < ApplicationController
  def index
    @pomodoros = Pomodoro.where user: current_user
  end

  def create
    new_pomodoro = Pomodoro.start(current_user)

    if (new_pomodoro)
      StopPomodoroService.create(new_pomodoro)
      redirect_to pomodoro_path new_pomodoro
    else
      message = "A timer have already been started."
      redirect_to pomodoros_path, flash: { error: message }
    end
  end

  def show
    @pomodoro = Pomodoro.find params[:id]
  end

  def destroy
    p = Pomodoro.find(params[:id])
    p.destroy!
    redirect_to pomodoros_path
  end
end
