
class Post < ApplicationRecord
  after_create :schedule_deletion

  private

  def schedule_deletion
    PostDeletionWorker.perform_in(24.hours, id)
  end

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  # Associations
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags
end
