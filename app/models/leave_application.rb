class LeaveApplication < ApplicationRecord
  belongs_to :user
  belongs_to :leave_type

  mount_uploader :attachment, AvatarUploader

  validates :leave_type, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :leave_duration, presence: true
  validates :reason, presence: true
  validate :valid_date
  validate :valid_length

  enum leave_duration: [ :full_day, :am, :pm ]
  enum status: [ :pending, :approved, :rejected ]

  def valid_length
    duration = start_date.business_days_until(end_date) + 1
    type = leave_type
    count = user.records.find_by_leave_type_id(type).days

    if duration > count
      errors.add(:end_date, " test")
    end
  end

  def valid_date
    if start_date > end_date
      errors.add(:start_date, " cannot be after end date")
    end
  end

  def start_time
    self.start_date
  end

  def end_time
    self.end_date
  end
end
