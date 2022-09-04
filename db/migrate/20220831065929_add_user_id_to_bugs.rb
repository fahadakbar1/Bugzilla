# frozen_string_literal: true

class AddUserIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :user_id, :integer
  end
end
