class WhoopsWeFuckedUp < ActiveRecord::Migration
  def change
    add_column :goals, :private, :boolean, null: false, default: false
  end
end
