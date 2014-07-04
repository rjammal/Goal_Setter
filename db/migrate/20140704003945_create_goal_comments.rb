class CreateGoalComments < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.text :body, null: false
      t.integer :author_id, null: false
      t.integer :comment_subject, null: false
      
      t.timestamps
    end
    
    add_index :goal_comments, :comment_subject
    add_index :goal_comments, :author_id
  end
end
