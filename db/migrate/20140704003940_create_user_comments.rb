class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.text :body, null: false
      t.integer :author_id, null: false
      t.integer :comment_subject, null: false
      
      t.timestamps
    end
    
    add_index :user_comments, :comment_subject
    add_index :user_comments, :author_id
  end
end
