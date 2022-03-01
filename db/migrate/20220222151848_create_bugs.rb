# frozen_string_literal: true

class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title, null: false
      t.string :description
      t.datetime :deadline
      t.integer :bug_type, null: false
      t.integer :status, null: false
      t.belongs_to :project
      t.integer :created_by_id, index: true, foreign_key: true
      t.integer :assigned_to_id, index: true, foreign_key: true

      t.timestamps
    end
    add_index 'bugs', %i[project_id title], unique: true
  end
end
