require 'role_model'

class User < ApplicationRecord
  has_many :leave_applications
  has_many :records
  has_many :leave_types, through: :records
  accepts_nested_attributes_for :records, allow_destroy: true

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :region, presence: true

  include RoleModel
  roles_attribute :roles_mask
  roles :employee, :head, :director, :admin

  enum department: [ :Tech, :Creative, :Sales, :Procurement, :Logistics, :People, :Finance ]
  enum region: [ :Malaysia, :Singapore ]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
