# frozen_string_literal: true

class AddDevIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :dev_id, :integer
  end
end
