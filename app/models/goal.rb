class Goal < ActiveRecord::Base
  validates :title, :user, presence: true
  validates :completed, :private, inclusion: { in: [true, false] }
  before_validation :ensure_completed_and_privacy
  
  belongs_to :user
  
  private
  
  def ensure_completed_and_privacy
    self.private ||= false
    self.completed ||= false
    true
  end
  
end