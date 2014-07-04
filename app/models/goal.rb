class Goal < ActiveRecord::Base
  validates :title, :user, presence: true
  validates :completed, :private, inclusion: { in: [true, false] }
  before_validation :ensure_completed_and_privacy
  
  belongs_to :user
  
  has_many(
  :comments,
  foreign_key: :comment_subject,
  primary_key: :id,
  class_name:  "GoalComment"
  )
  
  private
  
  def ensure_completed_and_privacy
    self.private ||= false
    self.completed ||= false
    true
  end
  
end