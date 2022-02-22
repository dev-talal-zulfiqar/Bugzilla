class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title, null: false, index: { unique: true }
      t.string :description
      t.datetime :deadline
      t.integer :bug_type, null: false
      t.integer :status, null: false
      t.belongs_to :project

      t.timestamps
    end
  end
end
