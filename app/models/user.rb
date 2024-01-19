class User < ApplicationRecord
  include JWTAuth # Assuming you have a module or gem for JWT authentication

  # Attributes that are mass assignable
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :phone, presence: true
  validates :password, presence: true
  validates :code, presence: true
  validates :expired_at, presence: true
  validates :active, inclusion: { in: [true, false] }
  validates :is_admin, inclusion: { in: [true, false] }

  # Attributes that should be hidden for serialization
  # and not shown in JSON responses
  # Example: user.to_json
  # Will not include password, remember_token
  # You might need to add other fields based on your specific needs
  attribute :password, :string, default: ""
  attribute :remember_token, :string, default: ""

  # Attribute casting
  attribute :email_verified_at, :datetime

  # Other model associations or custom methods can be added here

  def self.from_token_request(request)
    # Logic to extract user information from the token request
  end

  def self.from_token_payload(payload)
    # Logic to extract user information from the token payload
  end

  def generate_jwt
    # Logic to generate JWT token for the user
  end
end
