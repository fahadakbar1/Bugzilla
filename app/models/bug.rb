# frozen_string_literal: true

class Bug < ApplicationRecord
  validates :title, :bugtype, presence: true
  validate :attached_screenshot_type

  has_one_attached :screenshot
  belongs_to :project
  belongs_to :user

  enum bugtype: { bug: 0, feature: 1 }
  enum status: { newbug: 0, started: 1, resolved: 2, completed: 3 }

  private

  def attached_screenshot_type
    errors.add(:screenshot, 'must be PNG or GIF file') if screenshot.attached? && !screenshot.content_type.in?(%w[image/png image/gif])
  end
end
