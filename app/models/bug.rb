# frozen_string_literal: true

class Bug < ApplicationRecord
  validates :title, :bugtype, presence: true
  validate :attached_screenshot_type
  validates :title, uniqueness: { case_sensitive: false }
  validate :not_past_date

  has_one_attached :screenshot
  belongs_to :project
  belongs_to :user

  enum bugtype: { Bug: 0, Feature: 1 }
  enum status: { Newbug: 0, Started: 1, Resolved: 2, Completed: 3 }

  private

def not_past_date
  if self.deadline < Date.today
    errors.add(:deadline, ' of the bug can not be in the past')
  end
end


  def attached_screenshot_type
    errors.add(:screenshot, 'must be PNG or GIF file') if screenshot.attached? && !screenshot.content_type.in?(%w[image/png image/gif])
  end
end
