class UserComment < ActiveRecord::Base
  validates :body, :author, :user, presence: true
  
  belongs_to(
    :author, 
    foreign_key: :author_id, 
    class_name: "User"
  )
  
  belongs_to(
    :user, 
    foreign_key: :comment_subject, 
    class_name: "User"
  )
  
  
end