class Bug < ApplicationRecord
  belongs_to :user, optional: true,
  belongs_to :project
  enum bug_type: { feature: 0, bug: 1 }
  enum status: { opened: 0, started: 1, completed: 2, resolved: 3 }
end
