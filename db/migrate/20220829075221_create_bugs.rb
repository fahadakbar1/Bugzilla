# frozen_string_literal: true

class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title, index: { unique: true }, null: false
      t.text :description
      t.date :deadline

      t.timestamps
    end
  end
end
