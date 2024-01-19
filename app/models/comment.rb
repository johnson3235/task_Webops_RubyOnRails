# app/models/comment.rb

class Comment < ApplicationRecord
  # Attributes that are mass assignable
  validates :body, presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true

  # Associations
  belongs_to :user
  belongs_to :post

  # Other model associations or custom methods can be added here
end
