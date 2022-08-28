class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :set_user_role

  has_many :prouse
  has_many :projects, through: :prouse, dependent: :destroy

  private

   def set_user_role
    self.roles=[]
    self.add_role("#{user_type}")
   end

end
