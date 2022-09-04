# frozen_string_literal: true

class AddBugtypeToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :bugtype, :integer, default: 0
  end
end
