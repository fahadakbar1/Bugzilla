class AddBugtypeToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :bugtype, :integer
  end
end
