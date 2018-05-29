class ProfileController < ApplicationController
  def index

    if params[:id].present?
      @id = params[:id]
    else
      @id = current_user.id
    end
  end
end
