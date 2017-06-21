class ApprovalsController < ApplicationController
  def index
    @q = LeaveApplication.ransack(params[:q])

    if current_user.is? :director
      @leave_applications = @q.result.includes(:user)
    else
      ids = User.where(department: current_user.department).ids
      @leave_applications = @q.result.where(user_id: ids, status: 0).includes(:user)
    end
  end
end
