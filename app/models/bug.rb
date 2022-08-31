class Bug < ApplicationRecord

  validates :title,:bugtype, presence: true
  validate :attached_screenshot_type

  has_one_attached :screenshot

  belongs_to :project

  enum bugtype: {bug:0, feature:1}

  enum status: {newbug:0, started:1, resolved:2, completed:3}

private

def attached_screenshot_type

unless screenshot.content_type.in?(%w[image/png image/gif])
errors.add(:screenshot, 'must be PNG or GIF file')
end

end
end
