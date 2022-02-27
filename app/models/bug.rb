class Bug < ApplicationRecord
  belongs_to :user, optional: true, foreign_key: :created_by_id
  belongs_to :user, optional: true, foreign_key: :assigned_to_id
  belongs_to :project
  has_one_attached :screenshot
  enum bug_type: { feature: 0, bug: 1 }
  enum status: { opened: 0, started: 1, completed: 2, resolved: 3 }

  validates :title, :bug_type, :status, presence: true
end
