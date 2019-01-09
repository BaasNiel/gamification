class SprintsController < ApplicationController
  before_action :set_sprint, only: [:edit, :update, :destroy]

  def index
    if params.has_key?(:mine)
      @mine = true
      @sprints = current_user.sprints.page(params[:page]).order(id: :desc)
    else
      @sprints = current_user.team.sprints.page(params[:page]).order(id: :desc)
    end
  end

  def new
    @sprint = Sprint.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @sprint.update(sprint_params)
        format.html { redirect_to sprints_path, notice: 'Sprint was successfully updated.' }
        format.json { render :show, status: :ok, location: @sprint }
      else
        format.html { render :edit }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sprint.destroy
    respond_to do |format|
      format.html { redirect_to sprints_url, notice: 'Sprint was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    def set_sprint
      @sprint = Sprint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sprint_params
      params.require(:sprint).permit(:user_id, :start_date, :end_date, :expected_score, :actual_score)
    end
end
