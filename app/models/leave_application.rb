class LeaveApplication < ApplicationRecord
  belongs_to :user

  mount_uploader :attachment, AvatarUploader

  validates :leave_type, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :leave_duration, presence: true
  validates :reason, presence: true
  validate :valid_date

  enum leave_type: [ :annual, :sick, :unpaid ]
  enum leave_duration: [ :full_day, :am, :pm ]
  enum status: [ :pending, :approved, :rejected ]

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
