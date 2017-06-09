class LeaveTypesController < ApplicationController
  def new
    @leave_type = LeaveType.new
  end

  def create
    @leave_type = LeaveType.new(leave_type_params)

    if @leave_type.save
      redirect_to @leave_type
    else
      render 'new'
    end
  end

  private
    def leave_type_params
      params.require(:leave_type).permit(:leave_type)
    end
end
