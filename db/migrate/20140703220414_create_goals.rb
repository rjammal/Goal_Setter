class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.boolean :completed, null: false, default: false
      t.integer :user_id, null: false
      
      t.timestamps
    end
    
    add_index :goals, :user_id
  end
end
