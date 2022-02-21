class Project < ApplicationRecord
  has_many :projects_users
  has_many :users, through: :projects_users
  belongs_to :created_by, class_name: "User", foreign_key: :user_id
end