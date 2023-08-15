# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :set_user_role

  validates :username, presence: true
  validates :email, format: { with: /[\w.]+@(\w+\.)+\w{2,4}/, message: 'invalid pattern i.e test@gmail.com"' }, uniqueness: { case_sensitive: false }

  has_many :prouse, dependent: :destroy
  has_many :bugs, dependent: :destroy
  has_many :projects, through: :prouse, dependent: :destroy

  private

  def set_user_role
    self.roles = []
    add_role(user_type.to_s)
  end
end
