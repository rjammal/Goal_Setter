class Goal < ActiveRecord::Base
  validates :title, :user, presence: true
  validates :completed, inclusion: { in: [true, false] }
  before_validation :ensure_completed
  
  belongs_to :user
  
  private
  
  def ensure_completed
    self.completed ||= false
    true
  end
  
end