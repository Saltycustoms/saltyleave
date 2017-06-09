require 'role_model'

class User < ApplicationRecord
  has_many :leave_applications

  include RoleModel
  roles_attribute :roles_mask
  roles :employee, :head, :director, :admin

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
