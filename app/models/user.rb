# frozen_string_literal: true

class User < ApplicationRecord
  has_many :created_bugs, class_name: 'Bug', foreign_key: :created_by_id
  has_many :assigned_bugs, class_name: 'Bug', foreign_key: :assigned_to_id
  has_many :projects_users
  has_many :projects, through: :projects_users
  has_many :projects, foreign_key: :created_by, class_name: :Project

  enum role: { manager: 0, developer: 1, software_quality_assurance: 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
