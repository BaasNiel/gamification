class PomodorosController < ApplicationController
  def index
    @pomodoro = Pomodoro.current_pomodoro current_user
    @pomodoros = Pomodoro.where(user: current_user).order(created_at: :desc)
  end

  def create
    new_pomodoro = Pomodoro.start(current_user)

    if (new_pomodoro)
      StopPomodoroService.create(new_pomodoro)
      redirect_to pomodoros_path
    else
      message = "A timer have already been started."
      redirect_to pomodoros_path, flash: { error: message }
    end
  end

  def show
    @pomodoro = Pomodoro.find params[:id]

    respond_to do |format|
      format.json { render json: @pomodoro.to_json(methods: :remaining_seconds) }
      format.html { redirect_to pomodoros_path }
    end
  end

  def destroy
    p = Pomodoro.find(params[:id])
    p.destroy!
    redirect_to pomodoros_path
  end

  def stop
    change_status(:stop, :destroy)
  end

  def pause
    change_status(:pause, :destroy)
  end

  def resume
    change_status(:resume, :create)
  end

  private

  def change_status(pomodoro_operation, service_operation)
    @pomodoro = Pomodoro.find params[:id]

    if @pomodoro.send(pomodoro_operation)
      StopPomodoroService.send(service_operation, @pomodoro)
      redirect_to pomodoros_path
    else
      redirect_to pomodoros_path, flash: { error: "Idk" }
    end
  end
end
