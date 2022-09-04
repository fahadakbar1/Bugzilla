# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, length: { minimum: 5 }

  has_many :prouse, dependent: :destroy
  has_many :bugs, dependent: :destroy
  has_many :users, through: :prouse, dependent: :destroy
end
