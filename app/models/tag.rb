# app/models/tag.rb

class Tag < ApplicationRecord
  # Attributes that are mass assignable
  validates :name, presence: true

  # Associations
  has_and_belongs_to_many :posts

  # Other model associations or custom methods can be added here
end
