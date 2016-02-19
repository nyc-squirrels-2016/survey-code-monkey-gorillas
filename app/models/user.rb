class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :surveys
  has_many :user_answers
  has_many :answers, through: :user_answers

  has_secure_password
end
