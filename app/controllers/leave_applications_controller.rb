require 'open-uri'
class LeaveApplicationsController < ApplicationController
  before_action :authenticate_user!

  def download
    @leave_application = LeaveApplication.find(params[:id])
    url = @leave_application.attachment.file.to_file
    data = open(url).read
    send_data url, type: "image/jpeg", disposition: "attachment"
  end

  def index
    @leave_applications = LeaveApplication.where(user_id: current_user.id)
  end

  def show
    @leave_application = LeaveApplication.find(params[:id])
  end

  def new
    if current_user.leave_days <= 0
      #Placeholder: Display an error message
    else
      @leave_application = LeaveApplication.new
    end
  end

  def edit
    @leave_application = LeaveApplication.find(params[:id])
  end

  def create
    @leave_application = current_user.leave_applications.new(leave_application_params)

    if @leave_application.save
      redirect_to @leave_application
    else
      render 'new'
    end
  end

  def update
    @leave_application = LeaveApplication.find(params[:id])

    if @leave_application.update(leave_application_params)
      if @leave_application.approved?
        duration = @leave_application.start_date.business_days_until(@leave_application.end_date) + 1
        @leave_application.user.leave_days -= duration
      end
      @leave_application.user.save
      redirect_to @leave_application
    else
      render 'edit'
    end
  end

  private
    def leave_application_params
      params.require(:leave_application).permit(:leave_type, :start_date, :end_date, :leave_duration, :reason, :attachment, :status)
    end
end
