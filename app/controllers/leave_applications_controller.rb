require 'open-uri'
class LeaveApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_beginning_of_week

  def download
    @leave_application = LeaveApplication.find(params[:id])
    url = @leave_application.attachment.file.to_file
    data = open(url).read
    send_data url, type: "image/jpeg", disposition: "attachment"
  end

  def index
    @q = LeaveApplication.ransack(params[:q])

    ids = User.where(department: current_user.department).ids
    @leave_applications = @q.result.where(user_id: ids)
  end

  def show
    @leave_application = LeaveApplication.find(params[:id])
  end

  def new
    @leaves = LeaveApplication.all

    if current_user.annual_days > 0 && current_user.sick_days > 0 && current_user.unpaid_days > 0
      @leave_application = LeaveApplication.new
    else
      #Placeholder: Display an error message
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

        case @leave_application.leave_type
        when 0
          @leave_application.user.annual_days -= duration
        when 1
          @leave_application.user.sick_days -= duration
        when 2
          @leave_application.user.unpaid_days -= duration
        end
      end
      @leave_application.user.save
      redirect_to @leave_application
    else
      render 'edit'
    end
  end

  def destroy
    @leave_application = LeaveApplication.find(params[:id])
    @leave_application.destroy

    redirect_to leave_applications_path
  end

  private
    def leave_application_params
      params.require(:leave_application).permit(:leave_type, :start_date, :end_date, :leave_duration, :reason, :attachment, :status)
    end

    def set_beginning_of_week
      Date.beginning_of_week = :sunday
    end
end
