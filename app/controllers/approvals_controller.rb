class ApprovalsController < ApplicationController
  def index
    @q = LeaveApplication.ransack(params[:q])

    if current_user.is_director?
      @leave_applications = @q.result.where(status: 0)
    else
      ids = User.where(department: current_user.department).ids
      @leave_applications = @q.result.where(user_id: ids, status: 0)
    end
  end
end
