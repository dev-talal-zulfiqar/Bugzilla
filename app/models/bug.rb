# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :user, optional: true, foreign_key: :created_by_id, inverse_of: :created_bugs
  belongs_to :user, optional: true, foreign_key: :assigned_to_id, inverse_of: :assigned_bugs
  belongs_to :project
  has_one_attached :screenshot, dependent: :destroy

  enum bug_type: { feature: 0, bug: 1 }
  enum status: { opened: 0, started: 1, completed: 2, resolved: 3 }

  validates :title, :bug_type, :status, presence: true
  validates :title, uniqueness: { scope: :project }
  validate :screenshot_valid

  private

  def screenshot_valid
    return unless screenshot.attached?

    screenshot_type
    screenshot_size
  end

  def screenshot_type
    errors.add(:screenshot, 'needs to be a jpeg or png!') unless screenshot.content_type.in?(%('image/jpeg image/png'))
  end

  def screenshot_size
    errors.add(:screenshot, 'size should be less than 2MB') if screenshot.blob.byte_size > 25.megabytes
  end
end
