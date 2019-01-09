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

  def create
    @sprint = Sprint.new(sprint_params)

    respond_to do |format|
      if @sprint.save
        if current_user.admin?
          format.html { redirect_to sprints_path, notice: 'Sprint was successfully created.' }
          format.json { render :show, status: :created, location: @sprint }
        else
          format.html { redirect_to sprints_path, notice: 'Only the admin can create sprints.' }
          format.json { render :show, status: :created, location: @sprint }
        end
      else
        format.html { render :new }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def sprint_params
      params.require(:sprint).permit(:user_id, :start_date, :end_date, :expected_score, :actual_score)
    end
end
