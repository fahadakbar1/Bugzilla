# frozen_string_literal: true

class CreateProuses < ActiveRecord::Migration[5.2]
  def change
    create_table :prouses do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
