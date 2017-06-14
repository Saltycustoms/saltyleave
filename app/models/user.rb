require 'role_model'

class User < ApplicationRecord
  has_many :leave_applications

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
