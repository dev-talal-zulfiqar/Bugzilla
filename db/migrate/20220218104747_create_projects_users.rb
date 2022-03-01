# frozen_string_literal: true

class CreateProjectsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :projects_users do |t|
      t.belongs_to :user
      t.belongs_to :project

      t.timestamps
    end
  end
end
