# app/controllers/user_problems_controller.rb
class UserProblemsController < ApplicationController
  before_action :set_user_problem, only: [:update, :advance]

  def advance
    # Calculate the next status. Adjust these as needed.
    next_status = case @user_problem.status
                  when "not_started" then "in_progress"
                  when "in_progress" then "completed"
                  else "not_started"
                  end

    if @user_problem.update(status: next_status)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to problems_path, notice: "Status advanced." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("problem_#{@user_problem.problem.id}", partial: "problems/problem", locals: { problem: @user_problem.problem, user_problem: @user_problem }) }
        format.html { redirect_to problems_path, alert: "Error updating progress." }
      end
    end
  end

  private

  def set_user_problem
    @user_problem = current_user.user_problems.find(params[:id])
  end
end
