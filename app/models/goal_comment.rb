class GoalComment < ActiveRecord::Base
  validates :body, :author, :goal, presence: true
  
  belongs_to(
    :author, 
    foreign_key: :author_id, 
    class_name: "User"
  )
  
  belongs_to(
    :goal, 
    foreign_key: :comment_subject, 
    class_name: "Goal"
  )
  
  
end