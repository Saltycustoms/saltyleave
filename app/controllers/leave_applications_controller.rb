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
    @leaves = LeaveApplication.where(status: 1)

    ids = User.where(department: current_user.department).ids
    @leave_applications = @q.result.where(user_id: ids)
  end

  def show
    @leave_application = LeaveApplication.find(params[:id])
  end

  def new
    @leaves = LeaveApplication.where(status: 1)
    @leave_application = LeaveApplication.new
  end

  def edit
    @leave_application = LeaveApplication.find(params[:id])
  end

  def create
    @leave_application = current_user.leave_applications.new(leave_application_params)

    if @leave_application.save
      redirect_to @leave_application
    else
      @leaves = LeaveApplication.where(status: 1)
      render :new
    end
  end

  def update
    @leave_application = LeaveApplication.find(params[:id])
    @leave_application.update_attribute(:status, params[:status].to_i)

    if @leave_application.approved?
      duration = @leave_application.start_date.business_days_until(@leave_application.end_date) + 1
      type = @leave_application.leave_type_id
      @record = @leave_application.user.records.find_by_leave_type_id(type)
      @record.days -= duration
      @record.save
    end

    redirect_to approvals_path
  end

  def destroy
    @leave_application = LeaveApplication.find(params[:id])
    @leave_application.destroy

    if @leave_application.approved?
      duration = @leave_application.start_date.business_days_until(@leave_application.end_date) + 1
      type = @leave_application.leave_type_id
      @record = @leave_application.user.records.find_by_leave_type_id(type)
      @record.days += duration
      @record.save
    end

    redirect_back(fallback_location: root_path)
  end

  private
    def leave_application_params
      params.require(:leave_application).permit(:leave_type_id, :start_date, :end_date, :leave_duration, :reason, :attachment, :status)
    end

    def set_beginning_of_week
      Date.beginning_of_week = :sunday
    end
end
